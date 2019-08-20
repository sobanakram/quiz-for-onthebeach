require 'spec_helper'
require './lib/job_sorter'

RSpec.describe JobSorter do

  describe 'empty input string' do
    it 'returns an empty sequence' do
      job_sorter = JobSorter.new('')
      result = job_sorter.sort
      expect(result).to eq('')
    end
  end

  describe 'a job structure of a=>, b=>, c=>  with no dependencies' do
    it 'returns a sequence containing jobs abc in no significant order' do
      result = JobSorter.new('a=>, b=>, c=>').sort
      expect(result.split(' ')).to contain_exactly('a', 'b', 'c')
    end
  end

  describe 'a job structure of a=>, b=>c, c=> where b has a dependency' do
    it 'returns a sequence that positions c before b, and contains all three jobs abc' do
      result = JobSorter.new('a=>, b=>c, c=>').sort
      expect(result.split(' ')).to contain_exactly('a', 'b', 'c')
      expect(result.index('c')).to be < result.index('b')
    end
  end

  describe 'a job structure of a=>, b=>c, c=>f, d=>a, e=>b, f=>' do
    it 'returns a sequence that positions f before c, c before b, b before e, and a before d containing all six jobs abcdef' do
      result = JobSorter.new('a=>, b=>c, c=>f, d=>a, e=>b, f=>').sort
      expect(result.split(' ')).to contain_exactly('a', 'b', 'c', 'd', 'e', 'f')
      expect(result.index('f')).to be < result.index('c')
      expect(result.index('c')).to be < result.index('b')
      expect(result.index('b')).to be < result.index('e')
      expect(result.index('a')).to be < result.index('d')
    end
  end

  describe 'a job structure of a=>, b=>, c=>c where a self dependency occurs' do
    it 'returns an error stating that jobs can not depend on itself' do
      result = JobSorter.new('a=>, b=>, c=>c').sort
      expect(result).to eq('jobs can not depend on itself')
    end
  end

  describe 'a job structure of a=>, b=>c, c=>f, d=>a, e=>, f=>b where a circular dependency occurs' do
    it 'returns an error stating that jobs can not have circular dependencies' do
      result = JobSorter.new('a=>, b=>c, c=>f, d=>a, e=>, f=>b').sort
      expect(result).to eq('jobs can not have circular dependencies')
    end
  end

  describe 'a job structure of a=>, b=>, c=>, a=>b, b=>a with no dependencies' do
    it 'returns a sequence containing jobs abc in no significant order' do
      result = JobSorter.new('a=>, b=>, c=>, a=>b, b=>a').sort
      expect(result).to eq('jobs can not have circular dependencies')
    end
  end
end
