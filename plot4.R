epc <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";")
## common
GAP1 <- subset(epc, select = c(Date, Time, Global_active_power, Voltage, Global_reactive_power), subset = (Date == "1/2/2007"))
GAP2 <- subset(epc, select = c(Date, Time, Global_active_power, Voltage, Global_reactive_power), subset = (Date == "2/2/2007"))
GAP12 <- rbind(GAP1, GAP2)
a <- as.character(GAP12[,1])
b <- as.character(GAP12[,2])
d <- paste(a, b)
e <- strptime (d, format = "%d/%m/%Y %H:%M:%S", tz = "GMT")
Sys.setlocale("LC_TIME","English")
weekdays(Sys.Date()+1:3)

## GAP
GAP <- as.numeric(GAP12[,3])

## Voltage
VOL <- as.numeric(GAP12[, 4])

## ESM
ESM1 <- subset(epc, select = c(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3), subset = (Date == "1/2/2007"))
ESM2 <- subset(epc, select = c(Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3), subset = (Date == "2/2/2007"))
ESM12 <- rbind(ESM1, ESM2)
x1 <- as.numeric(as.character(ESM12[,3]))
x2 <- as.numeric(as.character(ESM12[,4]))
x3 <- as.numeric(as.character(ESM12[,5]))

## GRP
GRP <- as.numeric(GAP12[,5])

par(mfrow = c(2, 2), mar = c(4,4,2,2))
plot(e, GAP, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(e, VOL, type = "l", xlab = "datetime", ylab = "Voltage")
plot(e, x1, type = "l", xlab = "", ylab = "Energy sub metering", col ="black", ylim = c(0, max(x1)))
par(new=T)
plot(e, x2, type = "l", xlab = "", ylab = "Energy sub metering", col ="red", ylim = c(0, max(x1)))
par(new=T)
plot(e, x3, type = "l", xlab = "", ylab = "Energy sub metering", col ="blue", ylim = c(0,max(x1)))
par(new=T)
legend("topright", cex = 0.8, xjust = 1, yjust = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = "n", lty = 1)
plot(e, GRP, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "plot4.png")
dev.off()
