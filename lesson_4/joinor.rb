def joinor(ary, dlm = ',', word = 'or')
  new_string = ''
  ary.each_index do |num|
    if num == (ary.length - 1)
      new_string += word
      new_string += ' '
      new_string += ary[num].to_s
    else
      new_string += ary[num].to_s
      new_string += ', '
    end
  end
  new_string
end

print joinor([1, 3, 5, 7, 9], ',', "and")
