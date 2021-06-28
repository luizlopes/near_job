require 'rails_helper'

describe Scores::BackgroundMatchingScoreService do
  describe '.call' do
    subject(:call) { described_class.call(job: a_job, person: a_person) }

    let(:a_job) { build(:job, description: job_description) }
    let(:a_person) { build(:person, professional_background: professional_background) }

    context 'when professional background is nil' do
      let(:job_description) { 'Advanced Ruby' }
      let(:professional_background) { nil }

      it 'returns zero' do
        is_expected.to eq 0
      end
    end

    context 'when professional background is empty' do
      let(:job_description) { 'Advanced Ruby' }
      let(:professional_background) { '' }

      it 'returns zero' do
        is_expected.to eq 0
      end
    end

    context 'when professional background doesn\'t match job description' do
      let(:job_description) { 'Advanced Ruby' }
      let(:professional_background) { 'Python' }

      it 'returns zero' do
        is_expected.to eq 0
      end
    end

    context 'when professional background matches job description' do
      let(:job_description) { 'Advanced Ruby' }
      let(:professional_background) { 'Ruby' }

      it 'returns 50' do
        is_expected.to eq 50
      end
    end
  end
end
