class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
  # Make the id attribute read-only
  attr_reader :id
  
  # Make the name and grade writable and readable
  attr_accessor :name, :grade
  
  # Upon .new, accepts an arg for a student id, name, and grade and makes them instance vbariables
  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
  # Creates the students table with columns for id, name, and grade
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT)
      SQL
      
    DB[:conn].execute(sql)
  end
  
  # Method for dropping a table
  def self.drop_table
    sql = <<-SQL
      DROP TABLE students;
      SQL
      
    DB[:conn].execute(sql)
  end
  
  
  # Two part method
  def save
    # First part writes the new instance of student w/o an id value to the table
    sql = <<-SQL
      INSERT INTO students(name, grade)
      VALUES (?, ?);
      SQL
      
    DB[:conn].execute(sql, self.name, self.grade)
    
    # Second part gets the id from the table for the new student record and assigns it to the instance variable @id
    this_id = <<-SQL
      SELECT students.id FROM students DESC LIMIT 1;
      SQL
      
    DB[:conn].execute(this_id)
    @id = this_id
  end
  
  # Creates a new student instance with a name and grade, saves it to the table, gets and writes the id to the new instance @id value and returns the student instance with all three instance values
  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end
  
end