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
    var user_book_ids = []
    $(this).attr("user_book_ids").split(" ").forEach( (n) => { user_book_ids.push(parseInt(n)) })
    
    var current_book_id = parseInt($(".userBook").attr("book_id"));
    var all_book_ids = []
    $(this).attr("all_book_ids").split(" ").forEach( (n) => { all_book_ids.push(parseInt(n)) })

    var nextId = parseInt($(this).attr("book_id")) + 1;
    if (!all_book_ids.includes(nextId)) nextId = 1

        $.get(`/books/${nextId}.json`, {new_id: nextId}).done(function(book){
            $("#originalAddBookLink").hide()
            $("#bookmarks").hide()

            $("#bookTitle").text(book["title"]);
            $("#bookAuthor").text(book["author"]["name"]);
            $("#bookGenre").text(book["genre"]["title"]);
            // re-set the id to current on the link
            $(".userBook").attr("book_id", book["id"]);
            
            current_book_id = book["id"];

            if (user_book_ids.includes(current_book_id)) showBookMark(current_book_id); 
            if (!user_book_ids.includes(current_book_id)) hideBookMark(current_book_id);     
        })
  })  
};

function showBookMark(id){
  $("#bookmark-container").show()
  $("#bookmark-container").children().remove()
  $("#bookmark-container").append(`<a id="bookmarks" href="/user_books/${id}/edit">Bookmarks</a>`)

  hideAddBook()
}

function hideAddBook(){
  $("#addBookLink").hide()
}

function hideBookMark(id){
  $("#bookmarks").hide()
  showAddBook(id)
}

function showAddBook(id){

  $("#addBookLink").show()
  $("#addBookLink").children().remove()
  $("#addBookLink").append(`<a rel="nofollow" data-method="post" href="/addbook/${id}">Add Book</a>`)

}

function addBookForm(){
  $("input#addBookForm").parent().on("click", function(e){
    e.preventDefault()
    var url = this.action
    var $button = $(this)
    $(this).hide()
    $("#userNewBook").hide()

    $.get(url, function(bookForm){
      $button.after(bookForm)
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
    $.post(`/users/${uid}/books`, values, function(newBook){
        $("#submit-NewBook").closest("form").hide()
        $("input#addBookForm").parent().show()
        $("#userNewBook").show()


        
        var new_book = new Book(newBook["title"], newBook["author"]["name"], newBook["genre"]["title"], newBook["id"])
        $("#userNewBook").text(new_book.fullBook())
        $("ul#books").append(`<li><a href='/books/${new_book.id}'>${new_book.titleize(new_book.title)}</a>, by: ${new_book.titleize(new_book.author)}</li>`)

    });
  })
}   


function Book(title, author, genre, id) {
  this.title = title;
  this.author = author;
  this.genre = genre;
  this.id = id
}

Book.prototype.fullBook = function() {  return `New Book has been added to your library: ${this.title}, by: ${this.author}`;
}

Book.prototype.titleize = function(sentence) {
    if(!sentence.split) return sentence;
    var _titleizeWord = function(string) {
            return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
        },
        result = [];
    sentence.split(" ").forEach(function(w) {
        result.push(_titleizeWord(w));
    });
    return result.join(" ");
}


