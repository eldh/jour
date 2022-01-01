import React from 'react';
import SidebarView from './SidebarView.macos';
import {StyleSheet, View} from 'react-native';
import {make as RApp} from './src/App.bs';

const App = () => {
  return (
    <View style={styles.container}>
      <SidebarView style={styles.bg} />
      <RApp />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexGrow: 1,
  },
  bg: {
    position: 'absolute',
    top: '0%',
    left: '0%',
    width: '100%',
    height: '100%',
  },
});

export default App;
