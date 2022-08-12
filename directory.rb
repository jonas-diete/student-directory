@students = []
@cohorts = [:january, :november, :august]

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end

def process(selection)
  case selection
    when "1"
      students = input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      ask_for_file
    when "9"
      exit
    else
      puts "Unknown command"
  end
end

def show_students
  if !@students.empty?
    print_header
    print_students_list
    print_footer
  end
end

def save_students
  puts "Enter the filename:"
  filename = STDIN.gets.chomp
  if File.exist?(filename)
    File.open("students.csv", "w") do |file|
      @students.each do |student|
        student_data = [student[:name], student[:cohort], student[:hobby], student[:country]]
        csv_line = student_data.join(",")
        file.puts csv_line
      end
    end
    puts "List saved to students.csv"
  else
    puts "File doesn't exist."
  end
end
  
def load_students(filename = "students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do|line|
      name, cohort, hobby, country = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym, hobby: hobby, country: country}
    end
  end
  puts "Students loaded successfully."
end

def ask_for_file
  puts "Please enter the filename:"
  filename = STDIN.gets.chomp
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}."
  else
    puts "Sorry #{filename} doesn't exist."
  end
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students 
    return
  end
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}."
  else
    puts "Sorry #{filename} doesn't exist."
    exit
  end
end

def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return twice"
  puts "Please enter the name of the first student"
  name = STDIN.gets.strip
  while !name.empty? do
    puts "Please enter their hobby:"
    hobby = STDIN.gets.chomp
    puts "Please enter their country of birth:"
    country = STDIN.gets.chomp
    cohort = ""
    until @cohorts.include? cohort
      puts "Please enter their cohort:"
      cohort = STDIN.gets.chomp.to_sym
    end
    @students << {name: name, cohort: cohort, hobby: hobby, country: country}
    @students.count == 1 ? (puts "Now we have 1 student") : (puts "Now we have #{@students.count} students")
    puts "Please enter the name of the next student"
    name = STDIN.gets.strip
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end 

def print_students_list
  @students.each_with_index { |student, index| 
    puts "#{index + 1}. #{student[:name]}, hobby: #{student[:hobby]}, country of birth: #{student[:country]} (#{student[:cohort]} cohort)"
  }
end

def print_footer
  print "Overall, we have #{@students.count} great student"
  @students.count == 1  ? (print "\n") : (puts "s")
  puts " "
end

try_load_students
interactive_menu