import React from 'react';
import {SafeAreaView, StyleSheet, ScrollView, View} from 'react-native';
import {make as RApp} from './src/App.bs';
import {Colors} from 'react-native/Libraries/NewAppScreen';

const App = () => {
  return (
    <SafeAreaView style={styles.view}>
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        contentContainerStyle={styles.scrollView}>
        <RApp />
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  scrollView: {
    flex: 1,
    backgroundColor: 'yellow',
  },
  view: {
    flex: 1,
    // backgroundColor: 'red',
  },
});

export default App;
