$( document ).ready(function() {
       userBooks()
       showUserBook()
       addBookForm()
       submitNewBook()
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
    var nextId = parseInt($(this).attr("book_id")) + 1;
        $.get(`/books/${nextId}.json`, function(book){

            $("#bookTitle").text(book["title"]);
            $("#bookAuthor").text(book["author"]["name"]);
            $("#bookGenre").text(book["genre"]["title"]);
            // re-set the id to current on the link
            $(".userBook").attr("book_id", book["id"]);
        }).error(function(){ alert("No more books in list")})
  })  
};

function addBookForm(){
  $("input#addBookForm").parent().on("click", function(e){
    e.preventDefault()
    var url = this.action
    var $button = $(this)
    $(this).hide()

    $.get(url, function(response){
      $button.after(response)
    }).then(function(){
      $.getScript("/assets/author")
      $.getScript("/assets/genre")
      $.getScript("/assets/book")
    })
  })
}

function submitNewBook(){
  $("#submit-NewBook").on("click", function(e){
    e.preventDefault()
    var $form = this.closest("form")
    var uid = parseInt($(this).attr("uid"))
    var values = $($form).serialize() 
    $.post(`/users/${uid}/books`, values, function(response){
      console.log(response)
    });

  })
}


