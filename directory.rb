@students = []
@cohorts = [:january, :november, :august]

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
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
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobby], student[:country]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "List saved to students.csv"
end
  
def input_students
  puts "Please enter the details of the students"
  puts "To finish, just hit return twice"
  puts "Please enter the name of the first student"
  name = gets.strip
  while !name.empty? do
    puts "Please enter their hobby:"
    hobby = gets.chomp
    puts "Please enter their country of birth:"
    country = gets.chomp
    cohort = ""
    until @cohorts.include? cohort
      puts "Please enter their cohort:"
      cohort = gets.chomp.to_sym
    end
    @students << {name: name, cohort: cohort, hobby: hobby, country: country}
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    puts "Please enter the name of the next student"
    name = gets.strip
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end 

def print_students_list
  @cohorts.each { |cohort|
    @students.each_with_index { |student, index| 
      if cohort == student[:cohort]
        puts "#{index + 1}. #{student[:name]}, hobby: #{student[:hobby]}, country of birth: #{student[:country]} (#{student[:cohort]} cohort)".center(100) 
      end
    }
  }
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

interactive_menu