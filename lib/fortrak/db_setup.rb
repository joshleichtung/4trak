require 'sqlite3'

module ForTrak
  module DBSetup
    def db
      catch_errors { SQLite3::Database.new('4trak.db') }
    end

    def create_table(name = @db_name, columns = @db_columns)
      catch_errors { db.execute(create_table_query(name, @db_columns)) }
    end

    def delete_table(name)
      catch_errors { db.execute("DROP TABLE IF EXISTS #{name};") }
    end


    def create_table_query(name, fields)
      query = "CREATE TABLE IF NOT EXISTS #{name} (id INTEGER PRIMARY KEY, "
      query += fields.map{ |field| "#{field[0]} #{field[1]}" }.join(", ")
      query += ");"
    end

    private
    def catch_errors
      begin
        yield
      rescue SQLite3::Exception => e
        puts "SQLite exception occured"
        puts e
      end
    end
  end
end
