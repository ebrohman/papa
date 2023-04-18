# frozen_string_literal: true

member1 = User.create!(email: 'jim@papa.com')
member2 = User.create!(email: 'bill@papa.com')

member1.create_account(balance: 100)
member2.create_account(balance: 100.0)

visit1 = Visit.create!(member: member1,
                       minutes: 30,
                       rate: 1,
                       date: DateTime.current + 30.days)

completed_visit = Visit.create!(member: member1,
                                minutes: 30,
                                rate: 1,
                                date: DateTime.current - 1.day,
                                completed_at: DateTime.current)

Transaction.create!(member: member1,
                    pal: member2,
                    amount: 30)
