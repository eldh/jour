import React from 'react';
import {SafeAreaView, StyleSheet, View} from 'react-native';
import {make as RApp} from './src/App.bs';

const App = () => {
  return (
    <SafeAreaView style={styles.view}>
      <RApp />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  scrollView: {
    flex: 1,
    alignItems: 'center',
  },
  view: {
    flex: 1,
  },
});

export default App;
