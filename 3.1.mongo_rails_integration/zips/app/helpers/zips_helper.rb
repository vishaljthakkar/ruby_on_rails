module ZipsHelper
  def toZip(value)
    # change a value to zip if not already Zip
    value.is_a?(Zip) ? value : Zip.new(value)
  end
end
