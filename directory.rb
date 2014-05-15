@students = []
require 'date'

# def save_students
# 	file = File.open("students.csv", "w")
# 	@students.each do |student|
# 		csv_line = "#{student[:name]}, #{student[:cohort]}"
# 		file.puts csv_line
# 	end
# 	file.close
# end

# def save_students
# 	file = File.open("students.csv", "w")
# 	@students.each do |student|
# 		student_data = [student[:name], student[:cohort]]
# 		csv_line = student_data.join(",")
# 		file.puts csv_line
# 	end
# 	file.close
# end

def print_menu
	puts "1. Input the students"
	puts "2. Show the students"
	puts "9. Exit"
end

def show_students
	print_header
	print_students_list
	print_footer(@students)
end

def process(selection)
	case selection
	when "1"
		students = input_students
	when "2"
		show_students
	when "9"
		# save_students
		exit
	else 
		puts "I don't know what you meant, try again"
	end
end

def interactive_menu
	@students = []
	loop do
		print_menu
		process(gets.chomp)
	end
end

def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit enter on the student's name"
	name = gets.chomp
	while !name.empty? do
		puts "Now enter their cohort"
		cohort = gets.chomp
		while !(Date::MONTHNAMES).include? cohort.capitalize do
			puts "Did you get the month right? Please reenter:"
			cohort = gets.chomp
		end
		cohort = :May if cohort == ""
		cohort = cohort.to_sym
		@students << {name: name, cohort: cohort}
		if @students.length == 1
			puts "Now we have #{@students.length} student. Any more students?"
		else
			puts "Now we have #{@students.length} students. Any more students?"
		end
		name = gets.chomp
	end
	@students
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def print_students_list
	@students.each do |student|
		student.map {}
	end

	@students.each_with_index do |student, index|
	 	if student[:name].length < 12
	 		puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
	 	end
	end
end

def print_footer(names)
	if names.length == 1
		puts "Overall, we have #{names.length} great student"
	else 
		puts "Overall, we have #{names.length} great students"
	end
end


interactive_menu