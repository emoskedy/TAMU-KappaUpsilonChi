//= require jquery
//= require jquery_ujs

//= require_tree .

// $(function() {
//     $('.directUpload').find("input:file").each(function(i, elem) {
//       var fileInput    = $(elem);
//       var form         = $(fileInput.parents('form:first'));
//       var submitButton = form.find('input[type="submit"]'); 
//       console.log(submitButton); // Debugging: Check if submitButton is correctly selected
//       var progressBar  = $("<div class='bar'></div>");
//       var barContainer = $("<div class='progress'></div>").append(progressBar);
//       fileInput.after(barContainer);
//       fileInput.fileupload({
//         fileInput:       fileInput,
//         url:             form.data('url'),
//         type:            'POST',
//         autoUpload:       true,
//         formData:         form.data('form-data'),
//         paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
//         dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
//         replaceFileInput: false,
//         progressall: function (e, data) {
//           var progress = parseInt(data.loaded / data.total * 100, 10);
//           progressBar.css('width', progress + '%')
//         },
//         start: function (e) {
//           submitButton.prop('disabled', true);
  
//           progressBar.
//             css('background', 'green').
//             css('display', 'block').
//             css('width', '0%').
//             text("Loading...");
//         },
//         done: function(e, data) {
//           submitButton.prop('disabled', false);
//           progressBar.text("Uploading done");
  
//           // extract key and generate URL from response
//           var key   = $(data.jqXHR.responseXML).find("Key").text();
//           var url   = '//' + form.data('host') + '/' + key;
  
//           // create hidden field
//           var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url })
//           form.append(input);
//         },
//         fail: function(e, data) {
//           submitButton.prop('disabled', false);
  
//           progressBar.
//             css("background", "red").
//             text("Failed");
//         }
//       });
//     });
// });

$(function() {
    $('.directUpload').find("input:file").each(function(i, elem) {
        var fileInput = $(elem);
        var form = $(fileInput.parents('form:first'));
        var submitButton = form.find('input[type="submit"]');
        console.log(submitButton); // Debugging: Check if submitButton is correctly selected
        var progressBar = $("<div class='bar'></div>");
        var barContainer = $("<div class='progress'></div>").append(progressBar);
        fileInput.after(barContainer);
        fileInput.fileupload({
            fileInput: fileInput,
            url: form.data('url'),
            type: 'POST',
            autoUpload: false, // Set autoUpload to false
            formData: form.data('form-data'),
            paramName: 'file',
            dataType: 'xml',
            replaceFileInput: false,
            progressall: function(e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                progressBar.css('width', progress + '%')
            },
            start: function(e) {
                submitButton.prop('disabled', true);

                progressBar
                    .css('background', 'green')
                    .css('display', 'block')
                    .css('width', '0%')
                    .text("Loading...");
            },
            done: function(e, data) {
                submitButton.prop('disabled', false);
                progressBar.text("Uploading done");

                var key = $(data.jqXHR.responseXML).find("Key").text();
                var url = '//' + form.data('host') + '/' + key;

                var input = $("<input />", {
                    type: 'hidden',
                    name: fileInput.attr('name'),
                    value: url
                });
                form.append(input);
            },
            fail: function(e, data) {
                submitButton.prop('disabled', false);

                progressBar
                    .css("background", "red")
                    .text("Failed");
            }
        });

        // Manually trigger file upload on form submission
        form.on('submit', function(e) {
            e.preventDefault(); // Prevent default form submission
            fileInput.fileupload('send', { files: fileInput[0].files }); // Manually trigger file upload
        });
    });
});
