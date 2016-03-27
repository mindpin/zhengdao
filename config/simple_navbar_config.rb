# -*- encoding : utf-8 -*-
SimpleNavbar::Base.config do

  rule :dashboard do
    nav :courses, :name => '我的课程', :url => '/bank/dashboard/courses' do
      controller :"bank/dashboard", :only => :courses

      nav :join_courses, :name => '参加的', :url => '/bank/dashboard/join_courses' do
        controller :"bank/dashboard", :only => :join_courses
      end

      nav :fav_courses, :name => '参加的', :url => '/bank/dashboard/fav_courses' do
        controller :"bank/dashboard", :only => :fav_courses
      end
    end

    nav :test_questions, :name => '我的题库', :url => '/bank/dashboard/test_questions' do
      controller :"bank/dashboard", :only => :test_questions

      nav :test_question_records, :name => '做题记录', :url => '/bank/dashboard/test_question_records' do
        controller :"bank/dashboard", :only => :test_question_records
      end

      nav :flaw_test_questions, :name => '错题本', :url => '/bank/dashboard/flaw_test_questions' do
        controller :"bank/dashboard", :only => :flaw_test_questions
      end

      nav :fav_test_questions, :name => '收藏的题目', :url => '/bank/dashboard/fav_test_questions' do
        controller :"bank/dashboard", :only => :fav_test_questions
      end
    end

    nav :questions, :name => '我的问题', :url => '/bank/dashboard/questions' do
      controller :"bank/dashboard", :only => :questions
    end

    nav :notes, :name => '我的笔记', :url => '/bank/dashboard/notes' do
      controller :"bank/dashboard", :only => :notes
    end

  end

  rule :bank_courses_index do
    nav :recent, :name => '最新', :url => '/bank/courses' do
      controller :"bank/courses", :only => :index
    end

    nav :hot, :name => '最热', :url => '/bank/courses/hot' do
      controller :"bank/courses", :only => :hot
    end
  end

  rule :bank_courses_mine do
    nav :studying, :name => '正在学习', :url => '/bank/courses/studying' do
      controller :"bank/courses", :only => %i[mine studying]
    end

    nav :fav, :name => '课程收藏', :url => '/bank/courses/fav' do
      controller :"bank/courses", :only => %i[fav]
    end

    nav :studied, :name => '已经学完', :url => '/bank/courses/studied' do
      controller :"bank/courses", :only => %i[studied]
    end
  end

  rule :bank_my_test_questions do
    nav :records, :name => '做题记录', :url => '/bank/my_test_questions/records' do
      controller :"bank/my_test_questions", :only => %i[index records]
    end

    nav :flaw, :name => '错题本', :url => '/bank/my_test_questions/flaw' do
      controller :"bank/my_test_questions", :only => %i[flaw]
    end

    nav :fav, :name => '题目收藏', :url => '/bank/my_test_questions/fav' do
      controller :"bank/my_test_questions", :only => %i[fav]
    end
  end

  rule :bank_question_and_answer do
    nav :my_questions, :name => '我的问题', :url => '/bank/my_questions' do
      controller :"bank/my_questions", :only => :index
    end

    nav :my_answers, :name => '我的回答', :url => '/bank/my_answers' do
      controller :"bank/my_answers", :only => :index
    end
  end

  rule :bank_my_notes do
    nav :notes, :name => '所有笔记', :url => '/bank/my_notes' do
      controller :"bank/my_notes", :only => :index
    end
  end

  rule :engine_manager do
    nav :index, :name => '首页', :url => '/bank/manager/dashboard', html:{target: 'iframe_content'} do
      controller :'engine_manager/home'
    end

    nav :auth, :name => '课程管理', :url => '/bank/kc_courses', html:{target: 'iframe_content'} do
      controller :'kc_courses/courses'
    end
  end

  rule :bank_manage do
    nav :index, :name => '课程编排', :url => '/bank/manage/courses' do
      controller :'bank/manage/courses'
    end
  end
end
