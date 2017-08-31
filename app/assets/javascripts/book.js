$( document ).ready(function() {
       userBooks()
       showUserBook()
});

function userBooks(){
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
};

function showUserBook(){
  $(".userBook").on("click", function(e) {
    e.preventDefault()

    var userId = parseInt($(this).attr("user_id"))
    var bookId = parseInt($(this).attr("book_id"))

        $.get(`/users/${userId}/books/${bookId}.json`, function(book){
       
          debugger;
        })
  })  
};
