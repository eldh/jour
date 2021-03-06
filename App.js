import React from 'react';
import {SafeAreaView, StyleSheet, ScrollView} from 'react-native';
import {make as RApp} from './src/App.bs';

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
  },
  view: {
    flex: 1,
  },
});

export default App;
