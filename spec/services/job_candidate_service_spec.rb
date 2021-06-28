require 'rails_helper'

describe JobCandidateService do
  describe '.call' do
    subject(:job_candidate) { described_class.new.create(job_id: a_job.id, person_id: a_person.id) }

    before do
      create(:link, source: 'A', target: 'B', distance: 5)
      create(:link, source: 'B', target: 'C', distance: 7)
      create(:link, source: 'B', target: 'D', distance: 3)
      create(:link, source: 'C', target: 'E', distance: 4)
      create(:link, source: 'D', target: 'E', distance: 10)
      create(:link, source: 'D', target: 'F', distance: 8)

      create(:distance_factor, initial: 0, final: 5, factor: 100)
      create(:distance_factor, initial: 6, final: 10, factor: 75)
      create(:distance_factor, initial: 11, final: 15, factor: 50)
      create(:distance_factor, initial: 16, final: 20, factor: 25)
      create(:distance_factor, initial: 21, final: 999, factor: 0)
    end

    context 'when professional background doesn\'t match the job' do
      let(:a_job) do
        create(:job,
               title: 'Software Engineer',
               description: 'Ruby',
               localization: 'A',
               level: 3)
      end

      let(:a_person) do
        create(:person,
               name: 'Luiz',
               career: 'Developer',
               localization: 'B',
               level: 3,
               professional_background: 'Java')
      end

      it 'returns score 100' do
        expect(job_candidate.score).to eq 100
      end
    end

    context 'when professional background matches the job' do
      let(:a_job) do
        create(:job,
               title: 'Software Engineer',
               description: 'Ruby',
               localization: 'A',
               level: 3)
      end

      let(:a_person) do
        create(:person,
               name: 'Luiz',
               career: 'Developer',
               localization: 'B',
               level: 3,
               professional_background: 'Ruby')
      end

      it 'returns score 150' do
        expect(job_candidate.score).to eq 150
      end
    end
  end
end
