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
  validates :title, uniqueness: { scope: :author }
end

#irb
b = Book.new(author: 'Mary Jane Watson')
b.valid? # false
b.errors # "Title can't be empty"
b.save   # false
b.save!  # raise `ActiveRecord::RecordInvalid, "Title can't be empty"
```
@[2] (Definição da validação. `presence: true` valida se o atributo está presente e, no caso de strings se é diferente da string vazia. Outros tipos de validação incluem, mas não são limitados a, inclusão em `ranges`, unicidade, formato da string, ou qualquer método customizado, como validação de CPF/CNPJ.)
@[3] (Se a validação for `uniqueness: true` o registro não pode ser feito caso haja algum outro registro com o mesmo título no banco. Nesse caso, a opção `scope: :author` é passada, então podem existir dois livros com o mesmo nome, desde que sejam de diferentes autores.
@[8] (`#valid?` checa as validações do model e retorna `true` ou `false`. É chamado automaticamente quando se chama `#save`.)
@[9] (`#errors` array de erros que é populado quando `#valid?` é chamado. Retorna um array vazio caso não haja nenhum erro.)
@[10-11] (`save` retorna `false` se alguma validação falhar; `save!` dá um erro `ActiveRecord::RecordInvalid`.)

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
@title[Many-to-Many]
#### @size[0.6em](Many to Many)

```ruby
create_table :mentors do |t|
  t.string :name, null: false
end

create_table :students do |t|
  t.string :name, null: false
end

create_join_table :mentors, :students

# app/models/mentor.rb
class Mentor < ActiveRecord::Base
  has_and_belongs_to_many :students
end

# app/models/book.rb
class Book < ActiveRecord::Base
  has_and_belongs_to_many :mentors
end
```
@[1-9] (Criando as tabelas)
@[9] (Cria uma tabela `mentors_students` com as colunas `mentor_id` e `student_id`)
@[11-19] (Criando os models)
@[13] (Cria os métodos `#students`, `#students=`, `#student_ids`. `#student_ids=`)
@[18] (Cria os métodos `#mentors`, `#mentors=`, `#mentor_ids`. `#mentor_ids=`)

---
@title[Many-to-Many with named join table]

#### @size[0.6em](Many to Many com join table como model)

```ruby
create_table :mentors do |t|
  t.string :name, null: false
end

create_table :students do |t|
  t.string :name, null: false
end

create_join_table :mentors, :students, table_name: :mentorships do |t|
  t.string :subject, null: false
end

# app/models/mentorship.rb
class Mentorship < ActiveRecord::Base
  belongs_to :mentor
  belongs_to :student
  validates :subject, presence: true
end

# app/models/mentor.rb
class Mentor < ActiveRecord::Base
  has_many :mentorships
  has_many :students, through: :mentorships
end

# app/models/book.rb
class Book < ActiveRecord::Base
  has_many :mentorships
  has_many :mentors, through: :mentorships
end
```
@[9-11] (A tabela agora tem um nome diferente e uma coluna a mais)
@[13-18] (Mentorship agora é um model com suas próprias validações)
@[22-23,27-28] (`has_and_belongs_to_many` mudou para `has_many` e `has_many through:`)

---
@title[End]

# Dúvidas?
