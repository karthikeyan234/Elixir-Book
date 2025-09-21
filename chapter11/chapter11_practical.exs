###############################################################
# Chapter 11 Practical Exercises – Solutions
###############################################################

# Exercise 1: Setting Up the Project
# ----------------------------------
# Run in terminal:
#   mix phx.new expense_tracker
#   cd expense_tracker
#
# Generate authentication system:
#   mix phx.gen.auth Accounts User users
#
# Run migrations:
#   mix ecto.migrate
#
# Start the server:
#   mix phx.server
# Visit http://localhost:4000 and register a new user.

# -- After setup, you can test inside IEx:
#   iex -S mix
#   ExpenseTracker.Repo.all(ExpenseTracker.Accounts.User)


# Exercise 2: Adding Expenses
# ---------------------------
# Generate schema, context, and HTML for expenses:
#   mix phx.gen.html Finances Expense expenses \
#       description:string amount:decimal date:date
#
# Run migrations:
#   mix ecto.migrate
#
# Example test (test/expense_tracker/finances_test.exs):
defmodule ExpenseTracker.FinancesTest do
  use ExpenseTracker.DataCase
  alias ExpenseTracker.Finances

  test "create_expense/1 creates a valid expense" do
    {:ok, expense} =
      Finances.create_expense(%{
        description: "Lunch",
        amount: 200,
        date: ~D[2025-09-10]
      })

    assert expense.description == "Lunch"
  end
end


# Exercise 3: Filtering and Viewing Expenses
# ------------------------------------------
# In lib/expense_tracker/finances.ex:
def list_expenses_by_date(date) do
  import Ecto.Query
  from(e in Expense, where: e.date == ^date) |> Repo.all()
end

# Example test:
test "list_expenses_by_date/1 returns only matching expenses" do
  Finances.create_expense(%{description: "Dinner", amount: 300, date: ~D[2025-09-10]})
  Finances.create_expense(%{description: "Breakfast", amount: 150, date: ~D[2025-09-09]})

  result = Finances.list_expenses_by_date(~D[2025-09-10])
  assert Enum.count(result) == 1
end


# Exercise 4: Budgets and Alerts
# ------------------------------
# Generate schema:
#   mix phx.gen.html Finances Budget budgets \
#       limit:decimal month:integer user_id:references:users
#
# Run migrations:
#   mix ecto.migrate
#
# Add logic in finances.ex:
def over_budget?(user, month) do
  import Ecto.Query

  total =
    Repo.one(
      from e in Expense,
      where: e.user_id == ^user.id and fragment("extract(month from ?)", e.date) == ^month,
      select: sum(e.amount)
    )

  budget = Repo.get_by(Budget, user_id: user.id, month: month)
  total && budget && total > budget.limit
end

# Example test:
test "over_budget?/2 returns true when expenses exceed budget" do
  user = user_fixture()
  Finances.create_budget(%{limit: 500, month: 9, user_id: user.id})
  Finances.create_expense(%{description: "Shopping", amount: 600, date: ~D[2025-09-05], user_id: user.id})

  assert Finances.over_budget?(user, 9) == true
end


# Exercise 5: Generating Reports
# ------------------------------
# In finances.ex:
def monthly_summary(user, month) do
  import Ecto.Query

  Repo.all(
    from e in Expense,
    where: e.user_id == ^user.id and fragment("extract(month from ?)", e.date) == ^month,
    group_by: e.category,
    select: {e.category, sum(e.amount)}
  )
end

# Example test:
test "monthly_summary/2 groups expenses by category" do
  user = user_fixture()
  Finances.create_expense(%{description: "Groceries", amount: 200, date: ~D[2025-09-01], category: "Food", user_id: user.id})
  Finances.create_expense(%{description: "Dining", amount: 100, date: ~D[2025-09-02], category: "Food", user_id: user.id})

  summary = Finances.monthly_summary(user, 9)
  assert {"Food", Decimal.new(300)} in summary
end


# Exercise 6: Deployment
# ----------------------
# Prepare for production release:
#   MIX_ENV=prod mix release
#
# Deploy to Gigalixir:
#   gigalixir create
#   git push gigalixir main
#
# Or deploy to AWS/Docker depending on your setup.
#
# After deployment, test:
#   - Register a user
#   - Add an expense
#   - View reports
