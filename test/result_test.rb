require 'test_helper'
require 'fp_rb/result'

class ResultTest < Minitest::Test
  include FpRb

  describe "with_default" do
    it "return the value if success" do
      Result.ok(11).with_default(0).must_equal(11)
    end

    it "return the default value if failure" do
      Result.err("Explodes").with_default(0).must_equal(0)
    end
  end

  describe "map" do
    it "returns the mapped value on success value" do
      Result.ok(11).map { |a| a + 1 }.with_default(0).must_equal(12)
    end

    it "returns the error" do
      Result.err("FAIL").map { |a| a + 1 }.error.msg.must_equal("FAIL")
    end
  end

  describe "and_then" do
    it "returns the monadic success value" do
      Result.ok(11).and_then { |a| Result.ok(a + 1) }.with_default(0).must_equal(12)
    end

    it "returns the original error on failure" do
      Result.err("FAIL").and_then { |a| Result.ok(a + 1) }.error.msg.must_equal("FAIL")
    end

    it "returns the error in the and_then block" do
      Result.ok(11).and_then { |a| Result.err("FAIL") }.error.msg.must_equal("FAIL")
    end
  end

  describe "rescue" do
    it "Return block return value if no error is raised" do
      Result.rescue { 12 }.with_default(0).must_equal(12)
    end

    it "return an error message containing the provided value" do
      Result.rescue { raise "Error coucou" }.error.msg.must_match /coucou/
    end

    it "return an error message containing the provided value" do
      res = Result.rescue("FAIL") { raise "Error coucou" }
      res.error.msg.must_match /coucou/
    end
  end

  describe "mapping error" do
    it "maps the error" do
      res = Result.rescue("FAIL") { raise "Error coucou" }
      res.map_error { |e| old_err = e.dup; old_err.msg = "NewError"; old_err }.error.msg.must_equal "NewError"
    end
  end
end
