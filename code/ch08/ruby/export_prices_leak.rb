# Chapter 8, §8.4.1 (data-flow analyzers) — a resource leaked on one path.
# The file is opened near the top of export_prices and closed at the bottom,
# but the error-path `return` in between skips the close. RuboCop flags the
# fragile acquisition (rubocop 1.88.1 --only Style/AutoResourceCleanup):
#   C:  9:  9: Style/AutoResourceCleanup: Use the block version of File.open.
# The checks below prove the leak at runtime via ObjectSpace.

def export_prices(catalog, discounts, path)
  out = File.open(path, "w")
  out.write("item,price\n")
  catalog.sort.each do |item, price|
    pct = discounts.percent_for(item)
    return nil if pct < 0 || pct > 100    # error path: `out` is never closed
    final = (price * (1 - pct / 100.0)).round(2)
    out.write("#{item},#{final}\n")
  end
  out.close
  path
end

class FakeDiscounts                     # same stand-in as Chapter 9, §9.3
  def initialize(table)
    @table = table
  end

  def percent_for(item)
    @table.fetch(item, 0)
  end
end

require "tmpdir"
path = File.join(Dir.mktmpdir, "prices.csv")

# Normal path: file written and closed.
raise unless export_prices({ "mug" => 10.0, "bowl" => 12.0 },
                           FakeDiscounts.new({ "mug" => 25 }), path) == path
raise unless File.read(path) == "item,price\nbowl,12.0\nmug,7.5\n"

# Error path: a 120% discount triggers the early return and leaks the handle.
raise unless export_prices({ "mug" => 10.0 },
                           FakeDiscounts.new({ "mug" => 120 }), path).nil?
leaked = ObjectSpace.each_object(File).any? do |f|
  !f.closed? && f.path == path
rescue IOError
  false
end
raise "expected an unclosed handle" unless leaked
puts "leak confirmed on the error path; normal path wrote the file"
