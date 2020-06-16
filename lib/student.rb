class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table
    sql <<- SQL
      CREATE TABLE students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT);
        
      DB[:conn].execute(sql)
    SQL
  end
  
  def self.drop_table
    sql <<- SQL
      DROP TABLE students;
      
      DB[:conn].execute(sql)
    SQL
  end
  
  def save
    sql <<- SQL
      INSERT INTO students (id, name, album)
      VALUES (?, ?, ?);
      
      DB[:conn].execute(sql, self.id, self.name, self.grade)
    SQL
  end
  
  def self.create
    student = self.new(id, name, grade)
    student.save
  end
    
      
end
