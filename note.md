1) Create Migrations: 
	a) User: - email - neeed to write tests (completed)
			 - password digest (bcrypt)
			 - username
			 - friend_id
			 has_many :friendships, :foreign_key => "user_id", :class_name => "Friendships"
			 has_many :friends, :through => :friendships

			 has_many :user_books
			 has_many :books, through: :user_books

	b) Friendships - completed
			- user_id
			- friend_id

			belongs_to :user, :foreign_key => "user_id", :class_name => "User"
			belongs_to :friend, :foreign_key => "friend_id", :class_name => "User"  

	c) Books (completed)
			-title (done)
			-author_id (done)
			-genre_id (done)
			-user_id

			has_many :user_books
			belongs_to :author
			belongs_to :genre

	d) Authors (completed)
			-name

			has_many :books
			has_many :genres, through: :books (uniq values only)
 
	e) Genre (completed)
			-name

			has_many :books
			has_many :authors, through: :books (unique values)

	f) UserBooks (completed)
			user_id
			boo_id

			belongs_to :user
			belongs_to :user_books

			 
			 
