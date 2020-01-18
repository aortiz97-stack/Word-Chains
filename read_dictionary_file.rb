# File reads dictionary file and converts it into Set.
require 'set'
def read_dict_file(file_name)
    file = File.open(file_name)
    set = Set.new(file.readlines.map(&:chomp))
    file.close()

    set
    
end
