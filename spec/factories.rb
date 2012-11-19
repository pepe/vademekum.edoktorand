FactoryGirl.define do
  factory :questionnaire do
    name 'Basic questionnaire'
    desc 'Some basic questionnaire'
    type 'records'
    body <<BODY
??? Do you have head?

xxx
yes

??? How big?

___ Here goes head size

??? Color?

ooo
red
simply red
BODY
  end

  factory :questionnaire_with_sections, class: Questionnaire do
    name 'Questionnaire with sections'
    desc 'Some questionnaire with sections'
    type 'records'
    body <<BODY
### This section is about heads

??? Do you have head?

xxx
yes

??? How big?

___ Here goes head size

??? Color?

ooo
red
simply red
BODY
  end

  factory :document do
    name 'Basic document'
    desc 'Some basic document'
    body '# Some basic document'
    type 'records'
  end

  factory :account do
    login 'koska'
    name 'Joska Koska'
  end

  factory :admin, class: Account do
    login 'admin'
    name 'Adminus Maximus'
    role 'admin'
  end

  factory :expectations_document, class: Document do
    name 'Expectations'
    desc 'Some expectations document'
    body '# Some expectations document'
    type 'expectations'
  end
end
