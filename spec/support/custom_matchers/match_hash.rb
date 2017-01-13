# GitHub Gist
# kroehre/ gist:9cc209bcf43a1d1b001b
# より引用＆一部改造

# @abstract           json形式のhashのkeyの数と値、hashの構造、keyとvalueのペアの一致(hash完全一致、順不同)
#                     などをテストする.
# @params     [Hash]  un_jsonalized_expected これからjson形式のhashにするためのhash.
# @params     [Array] *spec_ignore_keys specを無視するkeyの配列.
# @example            *spec_ignore_keysはない場合はnilをある場合は、複数文字列で書いて下さい.
#                     expect(result).to match_hash_after_jsonalized(data,nil)
#                     expect(result).to match_hash_after_jsonalized(data, 'created_at', 'updated_at')
# @note               *spec_ignore_keysは省略できません。ない場合はnilを設定してください。
#                     expectedをjson形式にしているのはDate型のデータがあった場合、timezoneが合わなくなるからです.
# @yieldparam [String] key spec_ignore_keysに含まれるかどうかを調べるために使われるパラメータ.
# @yieldreturn        true: そのkeyの時のspecは無視する.
#                     false:そのkeyの時のspecは実行する.
# @see                https://gist.github.com/kroehre/9cc209bcf43a1d1b001b
RSpec::Matchers.define :match_hash_after_jsonalized do |un_jsonalized_expected, *spec_ignore_keys|
  include CustomMatcherSubMethods

  errors = []
  jsonalized_expected = JSON.parse(un_jsonalized_expected.to_json)
  ignore_spec = proc{|key| if spec_ignore_keys.include?(key) then true end}

  match do |actual|
    errors = match_hash(jsonalized_expected, actual, [], nil){
      |key| ignore_spec.call(key)
    }
    errors << is_expected_key_exists?(jsonalized_expected, actual, [], nil){
      |key| ignore_spec.call(key)
    }
    errors << is_actual_key_exists?(jsonalized_expected, actual, [], nil){
      |key| ignore_spec.call(key)
    }
    errors.flatten!
    errors.empty?
  end

  description do |actual|
    "matches hash #{expected}"
  end

  failure_message do |actual|
    errors.join("\n")
  end

end

# @abstract           json形式のhashのkeyの数と値の一致をテストする.(keyの完全一致、順不同).
# @params     [Hash]  un_jsonalized_expected これからjson形式のhashにするためのhash.
# @params     [Array] *spec_ignore_keys specを無視するkeyの配列.
# @example            *spec_ignore_keysはない場合はnilをある場合は、複数文字列で書いて下さい.
#                     expect(result).to match_hash_keys(data,nil)
#                     expect(result).to match_hash_keys(data, 'created_at', 'updated_at')
# @note               *spec_ignore_keysは省略できません。ない場合はnilを設定してください.
#                     expectedをjson形式にしているのはDate型のデータがあった場合、timezoneが合わなくなるからです.
# @yieldparam [String] value spec_ignore_keysに含まれるかどうかを調べるために使われるパラメータ.
# @yieldreturn        true: そのkeyの時のspecは無視する.
#                     false:そのkeyの時のspecは実行する.
# @see                https://gist.github.com/kroehre/9cc209bcf43a1d1b001b
RSpec::Matchers.define :match_hash_keys do |un_jsonalized_expected, *spec_ignore_keys|

  errors = []
  jsonalized_expected_keys = JSON.parse(un_jsonalized_expected.to_json).keys
  ignore_spec = proc{|value| if spec_ignore_keys.include?(value) then true end}

  match do |actual|
    actual_keys = actual.keys
    # expectedとactual文字列だったりシンボルだったりするので文字列に統一
    jsonalized_expected_keys.map!{|s| s.to_s}
    actual_keys.map!{|s| s.to_s}
    errors = match_array(jsonalized_expected_keys, actual_keys,[], nil){
      |value| ignore_spec.call(value)
    }
    errors.flatten!
    errors.empty?
  end

  description do |actual|
    "matches hash_keys #{expected}"
  end

  failure_message do |actual|
    errors.join("\n")
  end

  def match_array(expected, actual, errors, path)
    expected.each_with_index do |expected_value, i|
      actual_value = actual[i]
      if (yield actual_value) || (yield expected_value) then next end
      unless actual.include?(expected_value)
        errors_message = <<-EOS
        {
            json at key \'#{expected_value}\' is not contained in actual keys.
            please have to include \'#{expected_value}\' to arguments of match_hash_keys.

            expected: #{expected_value}
                 got:
        }
        EOS
        errors << errors_message
      end
      # actual_valueはnilの時がある。(expectedとactualの要素数は違う場合がある)
      unless expected.include?(actual_value) || (actual_value == nil)
        errors_message = <<-EOS
        {
            json at key \'#{actual_value}\' is not contained in expected keys.
            please have to include \'#{actual_value}\' to arguments of match_hash_keys.

            expected:
                 got: #{actual_value}
        }
        EOS
        errors << errors_message
      end
    end
    errors
  end
end


module CustomMatcherSubMethods

  private

  def is_expected_key_exists?(expected, actual, errors =[], path=nil)
    expected.each do |key, value|
      if yield key then next end
      unless actual.has_key?(key)
        errors_message = <<-EOS
        {

            json at key \'#{key}\' is not contained in actual keys.
            please have to include \'#{key}\' to arguments of match_hash_after_jsonalized.

            expected: #{key}
                 got:

        }
        EOS
        errors << errors_message
      end
    end
    errors
  end

  def is_actual_key_exists?(expected, actual, errors=[], pth=nil)
    actual.each do |key, value|
      if yield key then next end
      unless expected.has_key?(key)

        errors_message = <<-EOS
        {

            json at key \'#{key}\' is not contained in expected keys.
            please have to include \'#{key}\' to arguments of match_hash_after_jsonalized.

            expected:
                 got: #{key}

        }
        EOS
        errors << errors_message
      end
    end
    errors
  end

  def match_hash(expected, actual, errors = [], path = nil)
    expected.each do |key, value|
      if yield key then next end
      match_value(expected[key], actual[key], errors, "#{path}#{key}")
    end
    errors
  end

  def match_array(expected, actual, errors, path)
    expected.each_with_index do |i|
      match_value(expected[i],actual[i],errors, path)
    end
  end

  def match_value(expected, actual, errors, path)

    if expected.is_a?(Hash)
      match_hash(expected, actual, errors, path)
    elsif expected.is_a?(Array)
      match_array(expected, actual, errors, path)
    else

      unless expected === actual
        errors_message = <<-EOS
        {
            json at path \'#{path}\' is not equal to expected value.

                  key: #{path}
             expected: #{expected}
                  got: #{actual}
        }
        EOS
        errors << errors_message
      end
    end
  end
end
