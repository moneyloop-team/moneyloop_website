// Toolbar options for Quill
var options = {
    modules: {
        toolbar: {
            container: [
                [{ header: [1, 2, false] }],
                ['bold', 'italic', 'underline'],
                ['image', 'code-block']
            ],
            handlers:{
                image: imageHandler
            }
        }
    },
    theme: 'snow',
};

// Custom image handler - sends image to server instead of encoding it in Base64
function imageHandler() {
    const input = document.createElement('input');
    input.setAttribute('type', 'file');
    input.click();

    // Listen upload local image and save to server
    input.onchange = () => {
      const file = input.files[0];

      // file type is only image.
      if (/^image\//.test(file.type)) {
        saveToServer(file);
      } else {
        alert('Please only upload images.');
      }
    };
}

// AJAX request to the server - is handled in BlogController
function saveToServer(file) {
    // The file is an image
    const fd = new FormData();
    fd.append('image[photo]', file);

    $.ajax({
        url: "/blogs/upload",
        type: "POST",
        cache: false,
        contentType: false,
        processData: false,
        data: fd,
        beforeSend: function(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success: function(image) {
            // Append the image ID and insert it into the quill editor
            $('<input>', {
                type: 'hidden',
                name: 'blog[im_id][]',
                value: image.id
            }).appendTo('#blog_form');
            const range = quill.getSelection();
            quill.insertEmbed(range.index, 'image', `${image.image}`);
        },
        error: function() {
            alert("Unable to upload image. Try again.");
        }
      });
}

function parseQuill(content){
    // Go through the inner HTML and find all img tags
    // replace the src with ""
    var text = content.innerHTML;
    return text;
}
;
