@title[Introdução ao ActiveRecord]
# ActiveRecord
### Jaimerson Araújo

---
@title[Definição]

#### @size[0.6em](Definição)

> Active Record: An object that wraps a row
  in a database table or view, encapsulates the database
  access, and adds domanin logic on that data.

  *Martin Fowler*, Patterns of Enterprise Application Architecture (p 160)

---
@title[Rails ActiveRecord]
- 1 tabela (ou view) = 1 classe
- Classes ActiveRecord são models
- Atributos não são definidos na classe, são inferidos pelas colunas na tabela

---
@title[Convenções]

#### @size[0.6em](Convenções)
- Nomes de classes são no singular e nomes das tabelas são no plural
  - Ex: se a classe se chama `Book`, a tabela será `books`. Alguns plurais não regulares também são definidos por padrão, como `Person` e `people`.
- Todas as tabelas tem uma `int primary key` chamada `id`

---
@title[Example]

#### @size[0.6em](Exemplo)
```ruby
# db/migrate/create_books.rb
create_table :books do |t|
  t.string :title, null: false
  t.string :author, null: false
end

# app/models/book.rb
class Book < ActiveRecord::Base
end

# irb
# You can pass the attributes on initialization
b = Book.new(title: 'My Book')
# You can also set attributes like this
b.author = 'John Doe'
# Saves to database
b.save!
```
@[1-5] (Criação da tabela utilizando a DSL do ActiveRecord - Migrations)
@[7-9] (Model)
@[11-17] (Utilização do model)

---
@title[CRUD]

#### @size[0.6em](CRUD)
```ruby
# Create
book = Book.new(title: 'Foo', author: 'Bar')
book.save
# Same as before
Book.create(title: 'Foo', author: 'Bar')
# Read
p = Person.find(1) # Finds person with id = 1
john = Person.find_by(name: 'John Doe')
# Update
john = Person.find_by(name: 'John Doe')
john.update(name: 'Johnny')
# Update many
Person.where("name ILIKE 'john%'").update_all(age: 42)
# Delete
Person.find_by(name: 'John Doe').destroy # runs callbacks
Person.find_by(name: 'John Doe').delete # DB delete
```
@[1-3]
@[4-5] (`create` = `new + save`)
@[6-8]
@[9-11]
@[12-13] (`update_all` é mais rápido pois altera direto no DB, mas pula as validações)
@[14-16]

---
@title[Validations]

#### @size[0.6em](Validações)
```ruby
class Book < ActiveRecord::Base
  validates :title, :author, presence: true
end

#irb
b = Book.new(author: 'Mary Jane Watson')
b.valid? # false
b.errors # "Title can't be emtpy"
```

---
@title[Callbacks]

#### @size[0.6em](Callbacks)
```ruby
class Book < ActiveRecord::Base
  # ...
  before_save :do_stuff
  before_destroy :do_other_things

  private

  def do_stuff
    puts 'Doing stuff'
  end

  def do_other_things
    puts 'Doing other things'
  end
end

#irb
b = Book.create(author: 'Mary Jane Watson', title: 'SpiderMan')
# => Doing stuff
b.destroy
# => Doing other things
```
@[3] (`before_save` é chamado antes de persistir o objeto)
@[4] (`before_destroy` é chamado antes de destruir o objeto)
@[8-15] (Callback methods)
@[18] (`Book` é criado)
@[19] (Callback `before_save` é chamado antes de persistir no banco)
@[20] (`Book` é destruído)
@[21] (Callback `before_destroy` é chamado antes de destruir no banco)

---
@title[Associations]

#### @size[0.6em](Associations)
```ruby
create_table :authors do |t|
  t.string :name, null: false
end

create_table :books do |t|
  t.string :title, null: false
  t.references :author
end

# app/models/author.rb
class Author < ActiveRecord::Base
  has_many :books
end

# app/models/book.rb
class Book < ActiveRecord::Base
  belongs_to :author
end

# irb
a = Author.create(name: 'Agatha Christie')
b = Book.create(title: 'Something', author: Author.first)
b.author == a # true
b.author = Author.new(name: 'HP Lovecraft')
b.save
```
@[1-8] (Cria as tabelas)
@[7] (Cria uma coluna `author_id` com constraint `foreign key`)
@[10-18] (Criando os models)
@[12] (Cria os métodos `#books`, `#books=`, `book_ids`, `book_ids=`)
@[17] (Cria os métodos `#author`, `#author=`)
@[20-25] (Utilização dos models)

---
@title[End]

# Dúvidas?
