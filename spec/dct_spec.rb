# frozen_string_literal: true

RSpec.describe Dct do
  it 'has a version number' do
    expect(Dct::VERSION).not_to be nil
  end

  reference_dct_type2 = lambda do |vec|
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

  reference_dct_type3 = lambda do |vec|
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

  describe 'dct_type2' do
    describe 'size 3' do
      it 'match result of reference implementation' do
        vec = (1..3).map { |i| i}
        expect(Dct.dct_type2(vec)).to eq(reference_dct_type2.call(vec))
      end
    end

    describe 'size 128' do
      it 'match result of reference implementation' do
        vec = (1..128).map { |i| i}
        expect(Dct.dct_type2(vec)).to eq(reference_dct_type2.call(vec))
      end
    end
  end

  describe 'dct_type3' do
    describe 'size 3' do
      it 'match result of reference implementation' do
        vec = (1..3).map { |i| i}
        expect(Dct.dct_type3(vec)).to eq(reference_dct_type3.call(vec))
      end
    end

    describe 'size 128' do
      it 'match result of reference implementation' do
        vec = (1..128).map { |i| i}
        expect(Dct.dct_type3(vec)).to eq(reference_dct_type3.call(vec))
      end

      it 'can invert DCTII with scaling' do
        vec = (1..128).map { |i| i}
        dct_type2 = Dct.dct_type2(vec)
        inverted = Dct.dct_type3(dct_type2).map {|x| x * (2.0 / vec.length) }

        vec.each.with_index { |x, i|
          expect(x).to be_within(1e-7).of(vec[i])
        }
      end
    end
  end
end
