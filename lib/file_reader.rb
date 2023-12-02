class FileReader
  def self.read_lines(file)
    lines = []
    File.readlines(file, chomp: true).each do |line|
      lines.append(line)
    end
    lines
  end
end