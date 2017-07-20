1) Create Migrations: 
	a) User: - email
			 - password digest (bcrypt)
			 - username
			 - friend_id
			 has_many :friendships, :foreign_key => "user_id", :class_name => "Friendships"
			 has_many :friends, :through => :friendships


			 has_many :books
			 has_many :authors, through: :books
			 has_many :genres, through: :books

	b) Friendships
			- user_id
			- friend_id

			belongs_to :user, :foreign_key => "user_id", :class_name => "User"
			belongs_to :friend, :foreign_key => "friend_id", :class_name => "User"  

	c) Books
			-title
			-author_id
			-genre_id
			-user_id

			belongs_to :user
			belongs_to :author
			belongs_to :genre

	d) Authors
			-name

			has_many :books
			has_many :genres, through: :books
			has_many :users, through: :books

	e) Genre
			-name

			has_many :books
			has_many :authors, through: :books
			has_many :users, through: books

			 
			 
