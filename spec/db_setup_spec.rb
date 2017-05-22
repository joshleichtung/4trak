require 'rspec'
require_relative '../lib/fortrak/db_setup'

describe ForTrak::DBSetup do
  let(:table) do
    class Foo
      include ForTrak::DBSetup
      attr_accessor :db_name, :db_columns

      def initialize
        @db_name = 'foo'
        @db_columns = {foo: "VARCHAR(255)", bar: "INTEGER"}
      end
    end

    Foo.new
  end

  it "makes a new database from @db_name and @db_columns" do
    expect(table.create_table).to be_truthy
    expect(table.db.execute("PRAGMA table_info(foo)").join).to include "foo"
  end

  it "deletes a database" do
    expect{ table.delete_table("foo") }.to_not raise_error
    expect(table.execute("SELECT * FROM foo")).to be_falsey
  end
end
