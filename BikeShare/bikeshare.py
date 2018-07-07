import time
import calendar
import statistics as stats
import pandas as pd
import numpy as np

CITY_DATA = { 'Chicago': 'chicago.csv',
              'New York City': 'new_york_city.csv',
              'Washington': 'washington.csv' }

def get_months():
    """
    Helper function for getting a list of the get_months

    Returns:
        (tuple) months - names of the calendar months
    """
    return tuple(calendar.month_name)[1:]

def get_filters():
    """
    Asks user to specify a city, month, and day to analyze.

    Returns:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    """
    print('Hello! Let\'s explore some US bikeshare data!')
    # get user input for city (chicago, new york city, washington).
    city = ""
    while (city not in CITY_DATA):
        city = str(input("Enter the city (Chicago, New York City or Washington): ")).strip(" ").title()

    # get user input for month (all, january, february, ... , june)
    month = ""
    while (month not in get_months() and month != "All"):
        month = str(input("Enter the month (All, January, Febuary, ... December): ")).strip().title()

    # get user input for day of week (all, monday, tuesday, ... sunday)
    day = ""
    days_of_week = tuple(calendar.day_name)
    while (day not in days_of_week and day != "All"):
        day = str(input("Enter the day of the week (All, Monday, Tuesday, ... Sunday): ")).strip().title()

    print('-'*40)
    return city, month, day


def load_data(city, month, day):
    """
    Loads data for the specified city and filters by month and day if applicable.

    Args:
        (str) city - name of the city to analyze
        (str) month - name of the month to filter by, or "all" to apply no month filter
        (str) day - name of the day of week to filter by, or "all" to apply no day filter
    Returns:
        df - Pandas DataFrame containing city data filtered by month and
    """

    print('Loading the Data and Filtering...\n')
    start_time = time.time()

    # Load data file into a dataframe
    df = pd.read_csv(CITY_DATA[city])

    # Convert the Start Time column to datetime
    df['Start Time'] = pd.to_datetime(df['Start Time'])
    df['End Time'] = pd.to_datetime(df['End Time'])

    # Extract month and day of week from Start Time to create new columns
    df['Month'] = df['Start Time'].dt.month
    df['Day of Week'] = df['Start Time'].dt.weekday_name
    df['Start Hour'] = df['Start Time'].dt.hour
    df['End Hour'] = df['End Time'].dt.hour

    # Filter by month if applicable
    if month != 'All':
        # Use the index of the months list to get the corresponding int
        month = get_months().index(month) + 1
        # Filter by month to create the new DataFrame
        df = df[df['Month'] == month]

    # Filter by day of week if applicable
    if day != 'All':
        # Filter by day of week to create the new dataframe
        df = df[df['Day of Week'] == day]

    # Print the number of NaN values in our filtered data
    print("Number of NaN values in the filtered data for", city, month, day, ": ", df.isnull().sum().sum())
    print("Number of non-NaN values in the filtered data for", city, month, day, ": ", df.notnull().sum().sum())

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)
    return df


def time_stats(df):
    """Displays statistics on the most frequent times of travel."""

    print('\nCalculating The Most Frequent Times of Travel...\n')
    start_time = time.time()

    # Display the most common month
    print('Most Popular Month:', df['Month'].mode()[0])

    # Display the most common day of week
    print('Most Popular Day of the Week:', df['Day of Week'].mode()[0])

    # Display the most common start hour
    print("\nStart Hour Statistics:")
    print('Most Popular', df['Start Hour'].mode()[0])

    # Additional statistics for trip duration
    print('Additional Statistics:\n', df['Start Hour'].describe())

    # Display the most common start hour
    print("\nEnd Hour Statistics:")
    print('Most Popular', df['End Hour'].mode()[0])

    # Additional statistics for trip duration
    print('Additional Statistics:\n', df['End Hour'].describe())

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def station_stats(df):
    """Displays statistics on the most popular stations and trip."""

    print('\nCalculating The Most Popular Stations and Trip...\n')
    start_time = time.time()

    # Display most commonly used start station
    print('Most Popular Start Station:', df['Start Station'].mode()[0])

    # Display most commonly used end station
    print('Most Popular End Station:', df['End Station'].mode()[0])

    # Display most frequent combination of start station and end station trip
    most_popular_combo = df.groupby(['Start Station', 'End Station']).agg(lambda x: stats.mode(x)[0][0])
    print('Most Popular Combination of Start and End Station:', most_popular_combo)

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def trip_duration_stats(df):
    """Displays statistics on the total and average trip duration."""

    print('\nCalculating Trip Duration...\n')
    start_time = time.time()

    # Display total travel time
    print('Total:', df['Trip Duration'].sum())

    # Display mean travel time
    print('Mean:', df['Trip Duration'].mean())

    # Additional statistics for trip duration
    print('Additional Statistics:\n', df['Trip Duration'].describe())

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def user_stats(df):
    """Displays statistics on bikeshare users."""

    print('\nCalculating User Stats...\n')
    start_time = time.time()

    # Display user type totals
    print('User Type Totals:\n', df['User Type'].value_counts())

    # Display Gender totals
    try:
        print('\nGender Total:\n', df['Gender'].value_counts())
    except:
        print('Error retrieving Gender information from this data set')

    # Display earliest, most recent, and most common year of birth
    try:
        print("\nBirth Year Statistics:")
        print('Earliest {}\n Most Recent {}\n Most Common {}' \
        .format(df['Birth Year'].min(), df['Birth Year'].max(), df['Birth Year'].mode()[0]))
        # Additional statistics for Birth Year
        print('Additional Statistics:\n', df['Birth Year'].describe())
    except:
        print('Error retrieving Birth Year information from this data set')

    print("\nThis took %s seconds." % (time.time() - start_time))
    print('-'*40)


def main():
    while True:
        city, month, day = get_filters()
        df = load_data(city, month, day)

        try:
            time_stats(df)
            #station_stats(df)
            trip_duration_stats(df)
            user_stats(df)
        except Exception as e:
            print("Exception occurred: {}".format(e))

        restart = input('\nWould you like to restart? Enter Yes or No.\n')
        if restart.strip(" ").lower() != 'yes':
            break

if __name__ == "__main__":
	main()
