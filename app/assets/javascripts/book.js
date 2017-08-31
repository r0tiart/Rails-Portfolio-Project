$( document ).ready(function() {
    $(".userBooks").on("click", function(e) {
      e.preventDefault()
      var userId = parseInt($(this).attr("user_id"))
      $.get(`/users/${userId}/books.json`, function(books){
        var booksTitles = ""      
        books.forEach((book) => {
          booksTitles += `<li> ${book.title}  </li>`
        })
        $(`#userbooks-${userId}`).html(booksTitles)
      })
    })
});


