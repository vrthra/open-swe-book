# Section 3.4.1 (Given / When / Then) — cucumber-ruby step definitions that make the
# chapter's interpreter-alert scenarios executable. In a Cucumber project the
# definitions below live in features/step_definitions/ and the expect(...) matchers
# come from rspec-expectations. Here minimal stand-ins register the steps and a tiny
# runner feeds them the .feature text, so the file runs standalone with ruby.

FEATURE = <<~TEXT
  Feature: Interpreter alerts
    So that clinicians are prepared, staff want a visible interpreter flag.

    Scenario: Patient needs an interpreter
      Given a checked-in patient flagged for an interpreter
      When the clinician opens the visit
      Then an "interpreter needed" banner is shown

    Scenario: Patient does not need an interpreter
      Given a checked-in patient with no interpreter flag
      When the clinician opens the visit
      Then no interpreter banner is shown
TEXT

# --- clinic scheduling app code under test -------------------------------------

def check_in(interpreter:)
  { checked_in: true, interpreter: interpreter }
end

def open_visit(patient)
  { banners: patient[:interpreter] ? ['interpreter needed'] : [] }
end

# --- stand-ins for cucumber-ruby's Given/When/Then and rspec's expect ----------

STEPS = {}

def Given(text, &block)
  STEPS["Given #{text}"] = block
end

def When(text, &block)
  STEPS["When #{text}"] = block
end

def Then(text, &block)
  STEPS["Then #{text}"] = block
end

class Expectation
  def initialize(actual)
    @actual = actual
  end

  def to(matcher)
    raise "expected #{@actual.inspect} to match" unless matcher.call(@actual)
  end
end

def expect(actual) = Expectation.new(actual)
def include(item) = ->(actual) { actual.include?(item) }
def be_empty = ->(actual) { actual.empty? }

# --- step definitions (as printed in the book) ---------------------------------

Given('a checked-in patient flagged for an interpreter') do
  @patient = check_in(interpreter: true)
end

Given('a checked-in patient with no interpreter flag') do
  @patient = check_in(interpreter: false)
end

When('the clinician opens the visit') do
  @visit = open_visit(@patient)
end

Then('an "interpreter needed" banner is shown') do
  expect(@visit[:banners]).to include('interpreter needed')
end

Then('no interpreter banner is shown') do
  expect(@visit[:banners]).to be_empty
end

# --- tiny runner: the .feature text drives the assertions -----------------------

world = nil
passed = 0
FEATURE.each_line do |raw|
  line = raw.strip
  if line.start_with?('Scenario:')
    puts line
    world = Object.new # cucumber-ruby runs each scenario in a fresh World
    passed += 1
  elsif world && !line.empty?
    world.instance_exec(&STEPS.fetch(line)) # RuntimeError = failing scenario
    puts "    #{line} ... ok"
  end
end
puts "#{passed} scenarios passed"
