require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANGUAGE = 'en'

def prompt(message)
  puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_message(op)
  word = case op
           when '1'
             'Adding'
           when '2'
             'Subtracting'
           when '3'
             'Multiplying'
           when '4'
             'Dividing'
           end

  word
end

def integer?(input)
  input.to_i.to_s == input
end

def number?(input)
  /^\d+$/.match(input) || /^\d+\.\d+$/.match(input) || /^\.\d+$/.match(input)
end

def messages(message, lang='en')
  MESSAGES[lang][message]
end

prompt(messages('welcome')

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(messages('valid_name')
  else
    break
  end
end

prompt(messages('hi')

loop do # Main loop
  number1 = ''
  loop do
    prompt(messages('first_number')
    number1 = gets.chomp

    if number?(number1)
      break
    else
      prompt(messages('invalid_number')
    end
  end

  number2 = ''
  loop do
    prompt(messages('second_number')
    number2 = gets.chomp
    if number?(number2)
      break
    else
      prompt(messages('invalid_number')
    end
  end

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3 or 4")
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_f + number2.to_f           when '2'
             number1.to_f - number2.to_f           when '3'
             number1.to_f * number2.to_f           when '4'
             number1.to_f / number2.to_f
           end

  prompt("The result is #{result}.")

  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Goodbye!")
