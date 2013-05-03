module testbench;

   integer INPUT_FILE = -1, running = 0;
   integer temp = 0;

   integer foo = 0;

   initial begin
      INPUT_FILE = $fopen("input_data.txt", "r");

      while(running==1);

      while(foo < 10) begin

         $fscanf(INPUT_FILE, "%f\n", temp);
         $display("Read line: %d", temp);

         foo = foo + 1;

      end
      
      $stop;

      $fclose(INPUT_FILE);
   end

endmodule
