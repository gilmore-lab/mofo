mofo.RLS.file.convert <- function( dir=".", study="mofo-child-tuning" )

# mofo.RLS.file.convert( dir="~/", study="mofo-child-tuning" )
#	Opens PowerDiva 3.4 RLS.txt data file, drops unnecessary variables,
#		creates new factors based on iCond numbers and study, 
#		then exports a .Rdata and .csv file in the same directory. 
#		
#		Function returns the new, trimmed, data frame.
#
#		Used for Motion Form (MOFO) series of SSVEP Studies.
#
#	dir	: 	directory to look for file, default is "~/"
#	study:	"mofo-child-tuning"
#
#	To use, source("PATH2PROGRAM/mofo-RLS-file-convert.R") at R command line.
#	Call using mofo.RLS.file.convert()
#
#	Released under GPLv3 by Rick O. Gilmore, thatrickgilmore@gmail.com
#
#############################################################################

#############################################################################
#	History
#
#	2013-05-10-19:07	rog wrote
#	2013-05-13-22:05 	rog added read of SsnHeader.txt, CndParams*.txt
#	2013-05-14-07:55	rog fixed error in extracting condition, fname.out
#	2013-05-14-09:05 	rog added lines to export detailed condition info.
# 2015-12-09-08:55  ars begin updating for mofo

#############################################################################
#	Notes
#
#	2013-05-10-19:07	Needs better error checking. 
#	2013-05-10-19:07 	Change filename based on iSess


{

fname.rls = file.path( dir, "RLS.txt")
fname.ssn = file.path( dir, "SsnHeader.txt")
fname.cndParams = file.path( dir, "CndParams_MOFO_v3.txt")
fname.out = file.path( dir, "RLS-merged")

# nCond = 10
# nHarm = 12
# NCh = 128
# nDataPts = nHarm * NCh * nCond

# List of variables to drop from exported data frame
drops.rls = c("iTrial", "iCh", "iFr", "AF", "xF1", "xF2", "FK_Cond", "iBin", "SweepVal", "LSB", "RSB", "UserSc", "Thresh", "ThrBin", "Slope", "ThrInRange", "MaxSNR")

drops.cndParams = c("iSess")

#### Reads tab-delimited data file from file name, assumes header, fills in blank variables

msg = sprintf("Reading file %s into data frame.", fname.rls)
cat( msg, "\n", sep="" )
rls.data.df = read.delim( fname.rls, header=TRUE, sep="\t", fill=TRUE)
cat("\tData frame read.\n")

#### Open SsnHeader.txt file

msg = sprintf("Reading file %s into data frame.", fname.ssn)
cat( msg, "\n", sep="" )
ssn.df = read.delim( fname.ssn, header=TRUE, sep="\t", fill=TRUE )
cat("\tData frame read.\n")

#### Open CndParams.txt file

msg = sprintf("Reading file %s into data frame.", fname.cndParams )
cat( msg, "\n", sep="" )
cndParams.df = read.delim( fname.cndParams, header=TRUE, sep="\t", fill=TRUE )
cat("\tData frame read.\n")

#### Extract session variables from files

NCh = max( ssn.df$NChan )
nCond = max( cndParams.df$iCond )
nHarm = length( levels( rls.data.df$Harm ) )
nDataPts = nHarm * NCh * nCond

msg = sprintf("Session has %d channels * %d conditions * %d harmonics = %d data points.\n", NCh, nCond, nHarm, nDataPts )
cat( msg, sep="" )

#### PowerDiva 3.4 duplicates data in RLS.txt output, so take only first half

#cat("Trimming duplicate entries.\n")
#nrows = length( rls.data.df$iSess )
#halfnrows = nrows/2
#rls.trimmed.df = rls.data.df[1:halfnrows,]
#cndParams.df = cndParams.df[1:nCond,]
#ssn.df = ssn.df[1,]

#### Remove original frame to save memory
#rm( rls.data.df )

#### Recode iCond variable 

# If moco-3-pattern-adult, rad = iCond 1..3, rot = iCond 4..6, trans = iCond 7..9

msg = sprintf("This is a %s study. Making Speed and Direction factors.", study)
cat(msg, "\n", sep="")

if( study == 'mofo-child-tuning') 
{
	#	iCond	Coherence   Speed	  Direction	Density	Pattern
	#	1		  100-100		  1.2deg/s	0-180		  10-10	  trans dir-180, 
	#	2		  100-100		  1.2deg/s	0-45		  10-10	  trans dir-45
	#	3	  	100-100		  1.2deg/s	0-5			  10-10	  trans dir-5
	#	4		  0-100		    1.2deg/s	0-0			  10-10	  trans coh-100
	#	5		  100-100		  1.2deg/s	0-180		  10-0	  trans fig-only
	#	6		  100-100		  6deg/s	0-180		  10-10	  trans dir-180
	#	7		  100-100		  6deg/s	0-45		  10-10	  trans dir-45
	#	8		  100-100		  6deg/s	0-5			  10-10	  trans	dir-5
	#	9		  0-100		    6deg/s	0-0			  10-10	  trans coh-100
	# 10	  100-100		  6deg/s	0-180		  10-0	  trans fig-only
 # Pattern = factor( rep( c(1,2,3), each=(3*nHarm*NCh)) , labels=c("rad", "rot", "trans") )
  
 #  Speed = factor( rep( rep( c(1, 2, 3), each=(nHarm*NCh) ), times=3), labels=c("2deg/s", "4deg/s", "8deg/s"), ordered=TRUE)
  
Direction = factor( rep( c(1,2,3,4,5), each=(nHarm*NCh)) , labels=c("0-180", "0-45", "0-5" , "0-0", "0-180-no-bgnd" ))

Speed = factor( rep( rep( c(1, 2), each=(nHarm*NCh) ), times=5), labels=c("1.2deg/s", "6deg/s"), ordered=TRUE)

}

####	Fix iCh labels to remove hc and -Avg text for readability

Channel = factor( rls.data.df$iCh, labels=1:NCh )

####	Rename frequency channel for readability

cat("Renaming data frame variables for readability.\n")
Hz = rls.data.df$AF


#### 	Create channel group variable

#### Create "blank" factor
ChanGroup = rep( "other", nDataPts )

l.lat = ( Channel == 47 ) |
		( Channel == 51 ) |
		( Channel == 52 ) |
		( Channel == 58 ) |
		( Channel == 59 ) |
		( Channel == 64 ) |
		( Channel == 68 )

l.med = ( Channel == 60 ) |
		( Channel == 65 ) |
		( Channel == 66 ) |
		( Channel == 67 ) |
		( Channel == 69 ) |
		( Channel == 70 ) |
		( Channel == 73 )

med   = ( Channel == 71 ) |
		( Channel == 72 ) |
		( Channel == 74 ) |
		( Channel == 75 ) |
		( Channel == 76 ) |
		( Channel == 81 ) |
		( Channel == 82 )

r.med = ( Channel == 77 ) |
		( Channel == 83 ) |
		( Channel == 84 ) |
		( Channel == 85 ) |
		( Channel == 88 ) |
		( Channel == 89 ) |
		( Channel == 90 )

r.lat = ( Channel == 91 ) |
		( Channel == 92 ) |
		( Channel == 94 ) |
		( Channel == 95 ) |
		( Channel == 96 ) |
		( Channel == 97 ) |
		( Channel == 98 )

ChanGroup[ l.lat ] = "l.lat"
ChanGroup[ l.med ] = "l.med"
ChanGroup[ med ]   = "med"
ChanGroup[ r.med ] = "r.med"
ChanGroup[ r.lat ] = "r.lat"

ChanGroup = factor( ChanGroup )

####	Create new data frame with core variables
cat("Creating new data frame.\n")

# Copy rls.data.df to output frame, but drop unneeded variables
mofo.df = rls.data.df[, !names(rls.data.df) %in% drops.rls ]

# Add newly defined variables
mofo.df$Direction = Direction
mofo.df$Speed = Speed
mofo.df$Channel = Channel
mofo.df$ChanGroup = ChanGroup
mofo.df$Hz = Hz
mofo.df$Study = rep( study, nDataPts)

# from SsnHeader and CndParam files
mofo.df$DaqRateHz = rep( ssn.df$DaqRateHz, nDataPts )
mofo.df$ViewDist = cndParams.df$ViewDist[ mofo.df$iCond ]
mofo.df$MeanLum = cndParams.df$MeanLum[ mofo.df$iCond ]
mofo.df$Contrast = cndParams.df$Contrast[ mofo.df$iCond ]
mofo.df$FigPhase= cndParams.df$Fig.Phase[ mofo.df$iCond ]
mofo.df$FigType = cndParams.df$Fig.Type[ mofo.df$iCond ]
mofo.df$FigShape = cndParams.df$Fig.Shape[ mofo.df$iCond ]
mofo.df$Density1 = cndParams.df$Density1[ mofo.df$iCond ]
mofo.df$Density2 = cndParams.df$Density2[ mofo.df$iCond ]
mofo.df$ModType = cndParams.df$ModType[ mofo.df$iCond ]
mofo.df$AminPerUpdate = cndParams.df$ModInfo[ mofo.df$iCond ]
mofo.df$Pix.Size = cndParams.df$Pix.Size[ mofo.df$iCond ]

mofo.df$Operator = rep( ssn.df$Operator, nDataPts )
mofo.df$Sex = rep( ssn.df$Sex, nDataPts )
mofo.df$BirthDate = rep( ssn.df$BirthDate, nDataPts )
mofo.df$DueDate = rep( ssn.df$DueDate, nDataPts )
mofo.df$AgeDays = rep( ssn.df$DayAge, nDataPts )

# from CndParam file

mofo.df$Temp.Freq1 = cndParams.df$Temp.Freq1[ mofo.df$iCond ]
mofo.df$Dir.Mean1 = cndParams.df$Dir.Mean1[ mofo.df$iCond ]
mofo.df$Dir.Range1 = cndParams.df$Dir.Range1[ mofo.df$iCond ]
mofo.df$Displ1 = cndParams.df$Displ1[ mofo.df$iCond ]
mofo.df$Lifetime1 = cndParams.df$Lifetime1[ mofo.df$iCond ]
mofo.df$PctCoher1 = cndParams.df$PctCoher1[ mofo.df$iCond ]

mofo.df$Temp.Freq2 = cndParams.df$Temp.Freq2[ mofo.df$iCond ]
mofo.df$Dir.Mean2 = cndParams.df$Dir.Mean2[ mofo.df$iCond ]
mofo.df$Dir.Range2 = cndParams.df$Dir.Range2[ mofo.df$iCond ]
mofo.df$Displ2 = cndParams.df$Displ2[ mofo.df$iCond ]
mofo.df$Lifetime2 = cndParams.df$Lifetime2[ mofo.df$iCond ]
mofo.df$PctCoher2 = cndParams.df$PctCoher2[ mofo.df$iCond ]

#### Export data

msg = sprintf( "Exporting R data to %s.", paste( fname.out,".Rdata", sep="") )
cat( msg, sep="" )
save( mofo.df, file=paste( fname.out,".Rdata", sep="") )

msg = sprintf( "Exporting CSV data to %s.", paste(fname.out, ".csv", sep="") )
cat("\n", msg, sep="" )
write.table( mofo.df, file=paste(fname.out, ".csv", sep=""), sep=",", row.names=FALSE)

return=mofo.df

}
