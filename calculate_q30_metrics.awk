#!/bin/awk

BEGIN {

    # define quality codes
    quality_codes["!"] = 0
    quality_codes["\""] = 1
    quality_codes["#"] = 2
    quality_codes["$"] = 3
    quality_codes["%"] = 4
    quality_codes["&"] = 5
    quality_codes["'"] = 6
    quality_codes["("] = 7
    quality_codes[")"] = 8
    quality_codes["*"] = 9
    quality_codes["+"] = 10
    quality_codes[","] = 11
    quality_codes["-"] = 12
    quality_codes["."] = 13
    quality_codes["/"] = 14
    quality_codes["0"] = 15
    quality_codes["1"] = 16
    quality_codes["2"] = 17
    quality_codes["3"] = 18
    quality_codes["4"] = 19
    quality_codes["5"] = 20
    quality_codes["6"] = 21
    quality_codes["7"] = 22
    quality_codes["8"] = 23
    quality_codes["9"] = 24
    quality_codes[":"] = 25
    quality_codes[";"] = 26
    quality_codes["<"] = 27
    quality_codes["="] = 28
    quality_codes[">"] = 29
    quality_codes["?"] = 30
    quality_codes["@"] = 31
    quality_codes["A"] = 32
    quality_codes["B"] = 33
    quality_codes["C"] = 34
    quality_codes["D"] = 35
    quality_codes["E"] = 36
    quality_codes["F"] = 37
    quality_codes["G"] = 38
    quality_codes["H"] = 39
    quality_codes["I"] = 40
}

# ignore secondary reads
$2 !~secondary {

    # keep track of number of reads
    ++num_reads
    quality = $11


    #print $11"\n"quality"\n\n\n"

    # loope through each base in sequence and accumulate the number of bases with qual >=30 for each cycle
    for (ii = 1; ii <= length(quality); ii++) {
        if(quality_codes[substr(quality,ii,1)] >= 30){
            # if reverse read
            if($2==16){
              cycle = length(quality)-ii + 1
            }
            else{
                cycle = ii
            }
             ++q30bases[cycle]
        }
    } ## next ii

} # next line

END {

    #cumulative_cycle_total_bases = num_reads * length($11)

    # for each read length
    for (ii = 1; ii <= length($11); ii++) {

      # get total number of bases
      cumulative_cycle_total_bases = num_reads * ii

      # calculate cumulative q30 across all cycles
      if ($2==16){
          cumulative_cycle_q30 +=q30bases[length($11)-ii]
      }
      else{
            cumulative_cycle_q30 += q30bases[ii]
      }

      if (cumulative_cycle_total_bases == 0 ){
          print "Empty Sam file!"
          exit 1
       }

      # print output
      printf("%s,%d,%d,%0.2f\n",exp_id, ii, q30bases[ii], ( cumulative_cycle_q30/cumulative_cycle_total_bases ) )
      
      } # for loop ends here
} # END block ends here

