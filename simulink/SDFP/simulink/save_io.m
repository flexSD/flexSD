
% writing input and output code to text file 
fid=fopen('input_data.txt', 'wt');
fprintf(fid,'%d\n', input);           
fclose(fid);

fid=fopen('output_data.txt', 'wt');
fprintf(fid,'%d\n', output);           
fclose(fid);

%fid=fopen('final_data.txt', 'wt');
%fprintf(fid,'%d\n', lastadderout);           
%fclose(fid);

fid=fopen('parameters.txt', 'wt');
fprintf(fid,'Fs = %d\n', Fs);
fprintf(fid,'p0 = %f\n', p0);
fprintf(fid,'p1 = %f\n', p1);
fprintf(fid,'p2 = %f\n', p2);
fprintf(fid,'p3 = %f\n', p3);
fprintf(fid,'q0 = %f\n', q0);
fprintf(fid,'q1 = %f\n', q1);
fprintf(fid,'q2 = %f\n', q2);
fprintf(fid,'w = %d\n', w);
fprintf(fid,'d = %d\n', d);
fprintf(fid,'k_bitshift = %d\n', k_bitshift);
fprintf(fid,'k_preint = %d\n', k_preint);
fprintf(fid,'k_postint = %d\n', k_postint);
fclose(fid);
