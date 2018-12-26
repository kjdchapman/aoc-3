require './lib/view_all_claims'

describe ViewAllClaims do
  context 'counting contested squares' do
    subject do
      described_class.new.execute(claims: claims)
        .count{ |_, value| value.count > 1 }
    end

    context 'with blank input' do
      let(:claims) { [] }
      it { is_expected.to eq 0 }
    end

    context 'with one claim' do
      let(:claims) do
        [{ from_left: 0, from_top: 0, width: 1, height: 1 }]
      end

      it { is_expected.to eq 0 }
    end

    context 'with two identical claims' do
      let(:claims) do
        [{ from_left: 0, from_top: 0, width: 1, height: 1 },
        { from_left: 0, from_top: 0, width: 1, height: 1 }]
      end

      it { is_expected.to eq 1 }
    end

    context 'two claims with different x-positions' do
      let(:claims) do
        [{ from_left: 1, from_top: 0, width: 1, height: 1 },
        { from_left: 0, from_top: 0, width: 1, height: 1 }]
      end

      it { is_expected.to eq 0 }
    end

    context 'two claims with different y-positions' do
      let(:claims) do
        [{ from_left: 0, from_top: 1, width: 1, height: 1 },
        { from_left: 0, from_top: 0, width: 1, height: 1 }]
      end

      it { is_expected.to eq 0 }
    end

    context 'two claims, one wider, same start position' do
      let(:claims) do
        [{ from_left: 0, from_top: 0, width: 2, height: 1 },
        { from_left: 0, from_top: 0, width: 1, height: 1 }]
      end

      it { is_expected.to eq 1 }
    end

    context 'two claims, one wider, different start positions' do
      let(:claims) do
        [{ from_left: 1, from_top: 0, width: 1, height: 1 },
        { from_left: 0, from_top: 0, width: 2, height: 1 }]
      end

      it { is_expected.to eq 1 }
    end

    context 'two claims, one taller, different start positions' do
      let(:claims) do
        [{ from_left: 0, from_top: 1, width: 1, height: 1 },
        { from_left: 0, from_top: 0, width: 1, height: 2 }]
      end

      it { is_expected.to eq 1 }
    end

    context 'two claims with two overlaps' do
      let(:claims) do
        [{ from_left: 0, from_top: 1, width: 1, height: 3 },
        { from_left: 0, from_top: 2, width: 1, height: 3 }]
      end

      it { is_expected.to eq 2 }
    end

    context 'three claims' do
      let(:claims) do
        [{ from_left: 0, from_top: 0, width: 1, height: 1 },
        { from_left: 2, from_top: 2, width: 1, height: 1 },
        { from_left: 2, from_top: 2, width: 1, height: 1 }]
      end

      it { is_expected.to eq 1 }
    end
  end

  context 'finding the uncontested claim' do
    subject do
      described_class.new.execute(claims: claims)
        .find{|_, value| value.count == 1 }
        &.last&.first
    end

    context 'with blank input' do
      let(:claims) { [] }

      it { is_expected.to be_nil }
    end

    context 'with one claim' do
      let(:claims) do
        [{ id: "#1", from_left: 0, from_top: 0, width: 1, height: 1 }]
      end

      it 'matches the id' do
        expect(subject).to eq '#1'
      end
    end

    context "with a differently ID'd claim" do
      let(:claims) do
        [{ id: "#2", from_left: 0, from_top: 0, width: 1, height: 1 }]
      end

      it 'matches the id' do
        expect(subject).to eq '#2'
      end
    end

    context 'with two overlapping claims' do
      let(:claims) do
        [{ from_left: 0, from_top: 0, width: 2, height: 1 },
        { from_left: 0, from_top: 0, width: 1, height: 1 }]
      end

      it { is_expected.to be_nil }
    end
  end
end


