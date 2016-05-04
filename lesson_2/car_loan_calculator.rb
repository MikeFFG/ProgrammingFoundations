# car_loan_calculator.rb

# Variables
loan_amount = ''
annual_percentage_rate = ''
loan_duration_years = ''
monthly_interest_rate = ''
loan_duration_months = ''
keep_looping = ''

# Methods
def calculate_monthly_payment(amount, m_interest, m_duration)
  monthly_payment_numerator = amount * (m_interest * ((1 + m_interest)**m_duration))
  monthly_payment_denominator = (1 + m_interest)**m_duration - 1
  monthly_payment_numerator / monthly_payment_denominator
end

loop do
  # Main
  puts "Welcome to the Car Loan Calculator!"

  # Get loan amount
  puts "Please input the loan amount in dollars."

  loop do
    loan_amount = gets.chomp

    if loan_amount.empty? || loan_amount.to_f < 0
      puts "Please enter a positive number."
    else
      loan_amount = loan_amount.to_f
      break
    end
  end

  # Get APR
  puts "Please input your APR as a percentage. \nFor example, for 6.2% input 6.2."

  loop do
    annual_percentage_rate = gets.chomp

    if annual_percentage_rate.empty? || annual_percentage_rate.to_f < 0
      puts "Please enter a positive number."
    else
      monthly_interest_rate = annual_percentage_rate.to_f / 1200
      break
    end
  end

  # Get loan duration
  puts "Please input the duration of your loan in years."

  loop do
    loan_duration_years = gets.chomp

    if loan_duration_years.empty? || loan_duration_years.to_f < 0
      puts "Please enter a positive number."
    else
      loan_duration_months = loan_duration_years.to_f * 12
      break
    end
  end

  # Calculate
  monthly_payment = calculate_monthly_payment(loan_amount, monthly_interest_rate, loan_duration_months)

  # Return answer
  puts "Your monthly payments will be:"
  puts "$#{format('%02.2f', monthly_payment)}"

  # Loop again?
  puts "Would you like to make another calculation? Y for yes. N for no."

  loop do
    answer = gets.chomp.downcase
    if answer == 'y'
      keep_looping = 'y'
      break
    elsif answer == 'n'
      keep_looping = 'n'
      break
    else
      puts "Please enter Y or N only."
    end
  end

  break if keep_looping == 'n'
end
