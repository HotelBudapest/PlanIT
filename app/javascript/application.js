document.addEventListener("turbo:load", () => {
    document.querySelectorAll('.add_fields').forEach(button => {
      button.addEventListener('click', function(event) {
        event.preventDefault();
        let time = new Date().getTime();
        let link = event.currentTarget;
        let fields = link.dataset.fields.replace(/new_record/g, time);
        link.insertAdjacentHTML('beforebegin', fields);
      });
    });
  });
  