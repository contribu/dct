# frozen_string_literal: true

require 'dct/version'

module Dct
  def self.dct_type2(vec)
    (0..vec.length - 1).map do |k|
      sum = 0
      (0..vec.length - 1).each do |n|
        idx = (2 * n + 1) * k
        cos = Math.cos(Math::PI / (2 * vec.length) * idx)
        sum += vec[n] * cos
      end
      sum
    end
  end

  def self.dct_type3(vec)
    (0..vec.length - 1).map do |k|
      sum = 0.5 * vec[0]
      (1..vec.length - 1).each do |n|
        idx = n * (2 * k + 1)
        cos = Math.cos(Math::PI / (2 * vec.length) * idx)
        sum += vec[n] * cos
      end
      sum
    end
  end
end
