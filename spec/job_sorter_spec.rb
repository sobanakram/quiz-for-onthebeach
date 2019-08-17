require 'spec_helper'
require 'job_sorter'

RSpec.describe JobSorter do
  
  describe 'empty input string' do
    it 'returns an empty sequence' do
      pending
    end
  end

  describe 'a job structure of a=>, b=>, c=>  with no dependencies' do
    it 'returns a sequence containing jobs abc in no significant order' do
      pending
    end
  end

  describe 'a job structure of a=>, b=>c, c=> where b has a dependency' do
    it 'returns a sequence that positions c before b, and contains all three jobs abc' do
      pending
    end
  end

  describe 'a job structure of a=>, b=>c, c=>f, d=>a, e=>b, f=>' do
    it 'returns a sequence that positions f before c, c before b, b before e, and a before d containing all six jobs abcdef' do
      pending
    end
  end

  describe 'a job structure of a=>, b=>, c=>c where a self dependency occurs' do
    it 'returns an error stating that jobs can not depend on itself' do
      pending
    end
  end
  
  describe 'a job structure of a=>, b=>c, c=>f, d=>a, e=>, f=>b where a circular dependency occurs' do
    it 'returns an error stating that jobs can not have circular dependencies' do
      pending
    end
  end
end
