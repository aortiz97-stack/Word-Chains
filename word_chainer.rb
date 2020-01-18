# Given a word, this program returns words that differ by one letter in the dictionary (adjacent words)
require 'set'
require_relative "./read_dictionary_file.rb"
class WordChainer
    def initialize(dictionary_file_name)
       @dictionary = read_dict_file(dictionary_file_name)
       @current_words = []
       @all_seen_words = Hash.new
    end

    def adjacent?(word, other_word)
        already_one_diff = false

        (0...word.length).each do |i|
            if already_one_diff && word[i] != other_word[i]
                return false #filters out words wit more than one difference in letters
            end

            if word[i] != other_word[i]
                already_one_diff = true
            end  
        end

        already_one_diff
    end

    def adjacent_words(word)
        adjacent_set = @dictionary.select do |other_word|
            other_word.length == word.length && adjacent?(word, other_word)
        end

        adjacent_set
    end

    def explore_current_words
        new_current_words = []
        @current_words.each do |current_word|
            adjacent_words(current_word).each do |adjacent_word|
                if !@all_seen_words.include?(adjacent_word)
                    new_current_words << adjacent_word
                    @all_seen_words[adjacent_word] = current_word #adding to hash helps with building path
                end
            end
        end

        @all_seen_words.each do |adjacent_word, current_word|
            if current_word
                puts "Current word: " + current_word + "; Adjacent Word: " + adjacent_word
            else
                puts "Current word: N/A; " + "Adjacent Word: " + adjacent_word
            end
        end
        @current_words = new_current_words

        new_current_words
    end


    def build_path(target)
        path = [target]
        curr = target

        while path[0]
            path.unshift(@all_seen_words[curr])
            curr = path[0]
        end

        path
    end

    def run(source, target)
        @current_words = [source]
        @all_seen_words[source] = nil

        while !@current_words.empty?
            explore_current_words
        end

        p build_path(target)
    end
end

test = WordChainer.new("dictionary.txt")

test.run("hello", "agave")