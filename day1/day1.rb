require_relative '../lib/file_reader.rb'

def sanity_check
  raw_data = FileReader.read_lines('./sanity_data')
  get_calibration_number(raw_data)
end

def sanity_check_2
  raw_data = FileReader.read_lines('./sanity_data_2')
  get_calibration_number_words(raw_data)
end

def problem_1
  raw_data = FileReader.read_lines('./part1_data')
  get_calibration_number(raw_data)
end

def problem_2
  raw_data = FileReader.read_lines('./part2_data')
  get_calibration_number_words(raw_data)
end

def get_calibration_number_words(raw_data)
  matcher_dict = {
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }
  calibration_numbers = []
  raw_data.each do |line|
    cn = line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/).flatten
    numbers = cn.map do |number|
      if matcher_dict.keys.include?(number)
        matcher_dict[number]
      else
        number
      end
    end
    calibration_numbers.append(numbers.first + numbers.last)
  end
  calibration_numbers.map(&:to_i).sum
end

def get_calibration_number(raw_data)
  calibration_numbers = []
  raw_data.each do |line|
    cn = extract_calibration_number(line.scan(/\d/).join('')).to_i
    calibration_numbers.append(cn)
  end
  calibration_numbers.sum
end

def extract_calibration_number(line)
  chars = line.split('')
  chars.first + chars.last
end

puts sanity_check
puts problem_1
puts sanity_check_2
puts problem_2
