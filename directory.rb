def interactive_menu
  students = []
  cohorts = [:january, :november, :august]
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection
      when "1"
        students = input_students(cohorts)
      when "2"
        print_header
        print(students, cohorts)
        print_footer(students)
      when "9"
        exit
      else
        puts "Unknown command"
      end
  end
end

def input_students(cohorts)
  puts "Please enter the details of the students"
  puts "To finish, just hit return twice"
  students = []
  puts "Please enter the name of the first student"
  name = gets.strip
  while !name.empty? do
    puts "Please enter their hobby:"
    hobby = gets.chomp
    puts "Please enter their country of birth:"
    country = gets.chomp
    cohort = ""
    until cohorts.include? cohort
      puts "Please enter their cohort:"
      cohort = gets.chomp.to_sym
    end
    students << {name: name, cohort: cohort, hobby: hobby, country: country}
    if students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{students.count} students"
    end
    puts "Please enter the name of the next student"
    name = gets.strip
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end 

def print(students, cohorts)
  cohorts.each { |cohort|
    students.each_with_index { |student, index| 
      if cohort == student[:cohort]
        puts "#{index + 1}. #{student[:name]}, hobby: #{student[:hobby]}, country of birth: #{student[:country]} (#{student[:cohort]} cohort)".center(100) 
      end
    }
  }

end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

interactive_menu