-- Tạo dimension date
CREATE TABLE Dim_Date
(
    DateKey INT PRIMARY KEY, 
    [Day] INT NOT NULL,  
    [Month] INT NOT NULL,  
    [Year] INT NOT NULL,  
    [Quarter] INT NOT NULL, 
    [MonthName] VARCHAR(20) NOT NULL, 
    [DayOfWeek] INT NOT NULL,   
    DayOfWeekName VARCHAR(20) NOT NULL, 
    WeekOfYear INT NOT NULL, 
    MonthYear VARCHAR(7) NOT NULL 
);

-- Tạo dimension app
CREATE TABLE Dim_App
(
    AppAppleID BIGINT PRIMARY KEY, 
    AppName VARCHAR(255) NOT NULL 
);

-- Tạo dimension subscription
CREATE TABLE Dim_Subscription (
    SubscriptionAppleID BIGINT PRIMARY KEY,
    SubscriptionName VARCHAR(255) NOT NULL,
    SubscriptionGroupID BIGINT NOT NULL
);

-- Tạo dimension subscriber
CREATE TABLE Dim_Subscriber
(
    SubscriberID VARCHAR(50) PRIMARY KEY, 
    SubscriberIDReset VARCHAR(10)
);


-- Tao dimension country
CREATE TABLE Dim_Country (
    CountryCode VARCHAR(3) PRIMARY KEY,
    CountryName VARCHAR(100) NOT NULL
);

/*
CREATE TABLE Dim_ExchangeRates (
    CurrencyCode VARCHAR(3), 
    RateDate DATE, 
    RateToUSD DECIMAL(18, 8) NOT NULL, 
    CONSTRAINT PK_ExchangeRates PRIMARY KEY (CurrencyCode, RateDate)
);
*/

-- Tạo bảng fact SubscriptionSales
CREATE TABLE Fact_SubscriptionSales
(
    -- Các khóa ngoại (Dimension keys)
    EventDateKey INT NOT NULL, 
    AppKey BIGINT NOT NULL,
    SubscriptionKey BIGINT NOT NULL,
    CountryKey VARCHAR(3) NOT NULL, 
    SubscriberKey VARCHAR(50) NOT NULL,
	PurchaseDateKey INT NOT NULL, 

    -- Các measure giao dịch
    CustomerPrice DECIMAL(12,2) NOT NULL,
    CustomerCurrency VARCHAR(3) NOT NULL, 
    DeveloperProceeds DECIMAL(12,2) NOT NULL,
    ProceedsCurrency VARCHAR(3) NOT NULL,
    Device VARCHAR(50) NOT NULL,
    Refund VARCHAR(3) NULL, 
    Units Decimal(12,2) NOT NULL,
	CustomerPriceUSD DECIMAL(12,2) NOT NULL,

    -- Định nghĩa khóa chính là tập hợp các khóa ngoại (chỉ định giao dịch duy nhất)
    CONSTRAINT PK_Fact_SubscriptionSales PRIMARY KEY (EventDateKey, AppKey, SubscriptionKey, CountryKey, SubscriberKey, PurchaseDateKey),
       
    -- Ràng buộc khóa ngoại (Foreign Key Constraints)
    CONSTRAINT FK_EventDateKey FOREIGN KEY (EventDateKey) REFERENCES Dim_Date (DateKey),
    CONSTRAINT FK_AppKey FOREIGN KEY (AppKey) REFERENCES Dim_App (AppAppleID),
    CONSTRAINT FK_SubscriptionKey FOREIGN KEY (SubscriptionKey) REFERENCES Dim_Subscription (SubscriptionAppleID),
    CONSTRAINT FK_CountryKey FOREIGN KEY (CountryKey) REFERENCES Dim_Country (CountryCode),
    CONSTRAINT FK_SubscriberKey FOREIGN KEY (SubscriberKey) REFERENCES Dim_Subscriber (SubscriberID),
	CONSTRAINT FK_PurchaseDateKey FOREIGN KEY (PurchaseDateKey) REFERENCES Dim_Date (DateKey)
);

--
/*
drop table Fact_SubscriptionSales;
drop table Dim_ExchangeRates;
drop table Dim_Subscription;
drop table Dim_Subscriber;
drop table Dim_Country;
drop table Dim_App;
drop table Dim_Date;
*/
