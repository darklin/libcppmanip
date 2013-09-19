require 'rexml/document'

class SourceLocation
  attr_accessor :row, :col
  def self.row_col row, col
    loc = SourceLocation.new
    loc.row, loc.col = row, col
    loc
  end
  def to_s
    "#{@row}:#{@col}"
  end
end

class SourceReplacement
  attr_accessor :from, :to, :text
  def initialize from, to, text
    @from, @to, @text = from, to, text
  end
  def isInsertion
    @from.row == @to.row && @from.col == @to.col
  end
  def isFrom phrase, source
    getPhraseColumnAtRow(phrase, @from.row, source) == @from.col
  end
  def isTo phrase, source
    getPhraseColumnAtRow(phrase, @to.row, source) == (@to.col - phrase.length)
  end
  def to_s
    "#{@from} -> #{@to} : \'#{text}\'"
  end
private
  def getPhraseColumnAtRow phrase, row, source
    line = source.split("\n")[row]
    line.index(phrase) if line
  end
end

def loadReplacementsFromXml filename
  doc = File.open(filename) { |f| REXML::Document.new f }
  replacements = []
  doc.elements.each("boost_serialization/replacements/item") do |r|
    from = SourceLocation.row_col r.elements["from/row"].text.to_i, r.elements["from/col"].text.to_i
    to = SourceLocation.row_col r.elements["to/row"].text.to_i, r.elements["to/col"].text.to_i
    replacements << SourceReplacement.new(from, to, r.elements["text"].text)
  end
  replacements
end
