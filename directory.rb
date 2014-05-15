@students = []
require 'date'

def save_students
	file = File.open("students.csv", "w")
	@students.each do |student|
		csv_line = "#{student[:name]}, #{student[:cohort]}"
		file.puts csv_line
	end
	file.close
end

def load_students(filename = "students.csv")
	file = File.open(filename, "r")
	file.readlines.each do |line|
		name, cohort = line.chomp.split(',')
		@students << {name: name, cohort: cohort.to_sym}
	end
	file.close
end

def try_load_students
	filename = ARGV.first
	return if filename.nil?
	if File.exists?(filename)
		load_students(filename)
		puts "Loaded #{@students.length} from #{filename}"
	else
		puts "Sorry, #{filename} doesn't exist."
		exit
	end
end

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
	puts ""
	puts "1. Input the students"
	puts "2. Show the students"
	puts "3. Save the students list to students.csv"
	puts "4. Load the list from students.csv"
	puts "9. Exit"
end

def show_students
	print_header if @students.length > 0
	print_students_list
	print_footer(@students)
end

def process_input(selection)
	case selection
	when "1"
		input_students
	when "2"
		show_students
	when "3"
		save_students
		puts "List saved"
	when "4"
		load_students
		puts "csv contents loaded into current list"
	when "9"
		exit
	else 
		puts "I don't know what you meant, try again"
		p "you wrote #{selection}"
	end
end

def interactive_menu
	@students = []
	loop do
		print_menu
		process_input(STDIN.gets.chomp) # chomp could be replaced by gsub("\n", "")
	end
end

def input_students
	puts "Please enter the names of the students"
	puts "To finish, just hit enter on the student's name"
	name = STDIN.gets.chomp
	while !name.empty? do
		puts "Now enter their cohort"
		cohort = STDIN.gets.chomp
		while !(Date::MONTHNAMES).include? cohort.capitalize do
			puts "Did you get the month right? Please reenter:"
			cohort = STDIN.gets.chomp
		end
		cohort = :May if cohort == ""
		cohort = cohort.to_sym
		@students << {name: name, cohort: cohort}
		puts "Now we have #{@students.length} student#{optional_plural}. Any more students?"
		name = STDIN.gets.chomp
	end
end

def print_header
  puts "The student#{optional_plural} of my cohort at Makers Academy"
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
	puts "Overall, we have #{names.length} great student#{optional_plural}"
end


def optional_plural
	if @students.length != 1
		"s"
	end
end

interactive_menu